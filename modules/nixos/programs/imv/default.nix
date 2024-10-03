{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.imv;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.imv = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.programs.imv = {
      enable = true;

      settings = {
        binds = {
          j = "next";
          k = "prev";
        };

        options = {
          background = "#1f1f28";
          fullscreen = false;
          overlay = true;
          overlay_text_color = "#dcd7ba";
          overlay_background_color = "#363646";
          overlay_background_alpha = "ff";
          overlay_font = "monospace:13";
          overlay_position_bottom = false;
        };
      };
    };
  };
}
