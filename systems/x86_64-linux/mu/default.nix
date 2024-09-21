{ lib, pkgs, inputs, format, virtual, config, system, ... }:
with lib;
with lib.nixty; {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    ./hardware.nix
    (import ./disko.nix {
      ssd = "/dev/nvme0n1";
      hdd = "/dev/sda";
    })
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  disko.enableConfig = true;
  # hardware.amdgpu.amdvlk = true;

  apps = {
    ncmpcpp = enabled;
  };

  services = { mpd' = enabled; };

  suites = {
    desktop = enabled;
    dev = enabled;
  };

  system = {
    boot.efi = enabled;
    audio = enabled;
    fonts = enabled;
    locale = enabled;
    network = enabled;
    nix = enabled;
    time = enabled;
    shell.default = "nushell";
  };

  boot.supportedFilesystems = [ "btrfs" ];

  boot.loader.grub.enableCryptodisk = true;
  environment.etc."crypttab".text = ''
    cryptsec /dev/disk/by-partlabel/disk-secondary-luks /home/tyyago/.keyfile
  '';

  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     cores = 4;
  #     memorySize = 4096;
  #     qemu.options = [ "-vga std" "-accel kvm" ];
  #   };
  # };

  system.stateVersion = "24.05";
}
