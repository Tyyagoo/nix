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

  system.boot.efi = enabled;

  boot.loader.grub.enableCryptodisk = true;
  environment.etc."crypttab".text = ''
    cryptsec /dev/disk/by-partlabel/disk-secondary-luks /persist/secret.key
  '';

  system.storage.btrfs = {
    enable = true;
    wipeOnBoot = true;
  };

  security.gpg = enabled;

  system.stateVersion = "23.11";
}
