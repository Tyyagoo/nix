{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace}; let
  cfg = config.${namespace}.bundles.desktop;
  inherit (lib) mkIf;
in {
  options.${namespace}.bundles.desktop = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.vscodium];

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    "${namespace}" = {
      programs = {
        bitwarden.enable = true;
        brave.enable = true;
        btop.enable = true;
        cava.enable = true;
        discord.enable = true;
        dunst.enable = true;
        firefox.enable = true;
        imv.enable = true;
      };

      desktop = {
        hyprland.enable = false;
        gtk.enable = true;
        qt.enable = true;
        waybar.enable = false;
      };

      system = {
        audio.enable = true;
        fonts.enable = true;
      };
    };
  };
}
