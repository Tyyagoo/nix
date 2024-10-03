{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.cava;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.cava = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.programs.cava = {
      enable = true;

      settings = {
        color = {
          # gradient = 1;
          gradient_count = 8;
          gradient_color_1 = "#957fb8";
          gradient_color_2 = "#7e9cd8";
          gradient_color_3 = "#7fb4ca";
          gradient_color_4 = "#76946a";
          gradient_color_5 = "#98bb6c";
          gradient_color_6 = "#e6c384";
          gradient_color_7 = "#d27e99";
          gradient_color_8 = "#e46876";
        };
      };
    };
  };
}
