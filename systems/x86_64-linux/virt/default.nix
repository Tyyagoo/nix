{
    lib,
    pkgs,
    inputs,
    config,
    ...
}:
with lib;
with lib.nixty;
{
  imports = [
    ./hardware.nix 
    inputs.disko.nixosModules.disko
    (import ./disko.nix { ssd = "/dev/sda"; hdd = "/dev/sdb"; })
  ];

  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  system.stateVersion = "23.11";
}
