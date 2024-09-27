{ namespace, pkgs, ... }: {
  imports = [
    ./hardware.nix
    (import ./disko.nix {
      hdd = "/dev/sda";
      ssd = "/dev/nvme0n1";
    })
  ];

  ${namespace} = {
    system.boot.efi.enable = true;
    bundles.development.enable = true;
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [ snowfallorg.flake ];

  system.stateVersion = "24.05";
}
