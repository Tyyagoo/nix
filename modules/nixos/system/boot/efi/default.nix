{ config, lib, pkgs, namespace, ... }:
with lib.${namespace};
let
  cfg = config.${namespace}.system.boot.efi;
  inherit (lib) mkIf;
in {
  options.${namespace}.system.boot.efi = { enable = mkEnableOpt; };

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
