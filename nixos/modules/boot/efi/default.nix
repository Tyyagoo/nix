{ self, config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.boot.efi;
in {
  options.${namespace}.boot.efi = {
    enable = self.lib.mkBoolOpt' true;
  };

  config = lib.mkIf cfg.enable {
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
