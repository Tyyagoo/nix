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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11";
}
