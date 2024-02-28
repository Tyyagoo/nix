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
    grub = {
      enable = true;
      enableCryptodisk = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  # environment.etc."crypttab".text = ''check after installation'';

  system.stateVersion = "23.11";
}
