{ pkgs, ... }:
{
  imports = [
    (import ./disko.nix {
      hdd = "/dev/sda";
      ssd = "/dev/nvme0n1";
    })
  ];

  disko.enableConfig = true;

  boot = {
    supportedFilesystems = [ "btrfs" ];
    loader.grub.enableCryptodisk = true;
  };

  # automatic decryption of secondary disk
  environment.etc."crypttab".text = ''
    cryptsec /dev/disk/by-partlabel/disk-secondary-luks /home/tyyago/.keyfile
  '';
}
