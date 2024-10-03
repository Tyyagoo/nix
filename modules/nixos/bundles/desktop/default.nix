{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.desktop;
  inherit (lib) mkIf;
in
{
  options.${namespace}.bundles.desktop = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
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
        hyprland.enable = true;
        gtk.enable = true;
        qt.enable = true;
        waybar.enable = true;
      };

      system = {
        audio.enable = true;
        fonts.enable = true;
      };
    };
  };
}
