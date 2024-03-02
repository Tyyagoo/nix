{ ssd, hdd, ... }: {
  disko.devices = {
    disk = {
      main = {
        device = ssd;
        type = "disk";
        imageSize = "4G";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptmain";
                settings.allowDiscards = true;
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd " "noatime" ];
                      blankSnapshot = true;
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd " "noatime" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd " "noatime" ];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd " "noatime" ];
                      neededForBoot = true;
                    };
                    "/var/log" = {
                      mountpoint = "/var/log";
                      mountOptions = [ "compress=zstd " "noatime" ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "8G";
                    };
                  };
                };
              };
            };
          };
        };
      };
      secondary = {
        device = hdd;
        type = "disk";
        imageSize = "8G";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptsec";
                settings = {
                  allowDiscards = true;
                  keyFile = "/tmp/autogen.key";
                };
                # https://discourse.nixos.org/t/decrypting-other-drives-after-the-root-device-has-been-decrypted-using-a-keyfile/21281
                initrdUnlock = false;
                additionalKeyFiles = [ "/tmp/secret.key" ];
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/storage";
                };
              };
            };
          };
        };
      };
    };
  };
}
