{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    
    loader = {
      systemd-boot.enable = false;

      # efi = {
      #   canTouchEfiVariables = true;
      #   efiSysMountPoint = "/efi";
      # };

      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        # useOSProber = true;
        device = "nodev";
      };
    };
  };
}
