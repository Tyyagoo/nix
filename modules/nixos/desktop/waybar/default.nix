{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.waybar;
  inherit (lib) types mkIf;

  launcher = {

  };
in
{
  options.${namespace}.desktop.waybar = {
    enable = mkEnableOpt;

    horizontal = {
      enable = mkDisableOpt;
      style = mkOpt (enum [
        "float"
        "sticky"
      ]) "float" "Choose bar style";
    };

    vertical = {
      enable = mkDisableOpt;
      style = mkOpt (enum [
        "float"
        "sticky"
      ]) "sticky" "Choose bar style";
      position = mkOpt (enum [
        "left"
        "right"
      ]) "left" "Choose bar position";
    };
  };

  config = mkIf cfg.enable {
    home.programs.waybar = {
      enable = true;

      settings = {
        horizontal = {
            layer = "top";
        };

        vertical = {
            layer = "top";
        };
      };
    };
  };
}
