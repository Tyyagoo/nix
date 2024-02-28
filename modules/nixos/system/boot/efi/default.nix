{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.system.boot.efi;
in {
  options.system.boot.efi = with types; {
    enable = mkBoolOpt false "Enable efi booting";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
      };
    };
  };
}
