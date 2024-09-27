{ namespace, pkgs, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    # inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./hardware.nix
    (import ./disko.nix {
      hdd = "/dev/sda";
      ssd = "/dev/nvme0n1";
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
    bundles = {
      common.enable = true;
      desktop.enable = true;
    };
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [ snowfallorg.flake ];

  system.stateVersion = "24.05";
}
