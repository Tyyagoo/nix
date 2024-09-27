{ config, inputs, lib, pkgs, namespace, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.disko.nixosModules.disko
    (import ./disko.nix {
      ssd = "/dev/nvme0n1";
      hdd = "/dev/sda";
    })
  ];

  disko.enableConfig = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = [ "btrfs" ];
    loader.grub.enableCryptodisk = true;
  };

  environment.etc."crypttab".text = ''
    cryptsec /dev/disk/by-partlabel/disk-secondary-luks /home/tyyago/.keyfile
  '';

  ${namespace} = {
    boot.efi.enable = true;
  };

  system.stateVersion = "24.05";
}
