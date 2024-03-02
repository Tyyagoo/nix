{ lib, pkgs, inputs, format, virtual, config, ... }:
with lib;
with lib.nixty;
#let baremetal = !virtual && format != "iso"; in
{
  imports = [
    ./hardware.nix
    #inputs.disko.nixosModules.disko
    #(import ./disko.nix {
    #  ssd = "/dev/nvme0n1";
    #  hdd = "/dev/sda";
    #})
  ];

  # disko.enableConfig = baremetal;
  security.gpg = enabled;

  system = {
    #boot.efi = enabled;
    audio = enabled;
    locale = enabled;
    network = enabled;
    nix = enabled;
    time = enabled;
    #storage.btrfs = mkIf baremetal {
    #  enable = true;
    #  wipeOnBoot = true;
    #};
  };

  tools.git = enabled;

  virtualisation.vmVariant = {
    virtualisation = {
      cores = 4;
      memorySize = 4096;
      qemu.options = [ "-vga std" "-accel kvm" ];
    };
  };

  system.stateVersion = "23.11";
}
