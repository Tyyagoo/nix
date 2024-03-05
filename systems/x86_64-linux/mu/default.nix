{ lib, pkgs, inputs, format, virtual, config, ... }:
with lib;
with lib.nixty;
let baremetal = !virtual && format != "iso";
in {
  imports = [
    ./hardware.nix
    inputs.disko.nixosModules.disko
    (import ./disko.nix {
      ssd = "/dev/nvme0n1";
      hdd = "/dev/sda";
    })
  ];

  disko.enableConfig = baremetal;

  apps = { ncmpcpp = enabled; };

  desktop.hyprland = enabled;

  security = { gpg = enabled; };

  services = { mpd' = enabled; };

  system = {
    boot.efi = enabled;
    audio = enabled;
    fonts = enabled;
    locale = enabled;
    network = enabled;
    nix = enabled;
    time = enabled;
    storage.btrfs = mkIf baremetal {
      enable = true;
      wipeOnBoot = false;
    };
  };

  tools = { git = enabled; };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = [ pkgs.firefox ];

  boot.loader.grub.enableCryptodisk = true;
  environment.etc."crypttab".text = ''
    cryptsec /dev/disk/by-partlabel/disk-secondary-luks /persist/secret.key
  '';

  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     cores = 4;
  #     memorySize = 4096;
  #     qemu.options = [ "-vga std" "-accel kvm" ];
  #   };
  # };

  system.stateVersion = "23.11";
}
