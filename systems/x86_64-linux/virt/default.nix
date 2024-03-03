{ lib, pkgs, inputs, config, ... }:
with lib;
with lib.nixty; {
  imports = [
    ./hardware.nix
    inputs.disko.nixosModules.disko
    (import ./disko.nix {
      ssd = "/dev/sda";
      hdd = "/dev/sdb";
    })
  ];

  system = {
    boot.efi = enabled;
    audio = enabled;
    locale = enabled;
    network = enabled;
    nix = enabled;
    storage.btrfs = {
      enable = true;
      wipeOnBoot = false;
    };
    time = enabled;
  };

  boot.loader.grub.enableCryptodisk = true;
  environment.etc."crypttab".text = ''
    cryptsec /dev/disk/by-partlabel/disk-secondary-luks /persist/secret.key
  '';

  desktop.gnome = enabled;

  tools.git = enabled;
  security.gpg = enabled;

  system.stateVersion = "23.11";
}
