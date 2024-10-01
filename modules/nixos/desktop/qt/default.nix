{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.qt;
  inherit (lib) mkIf;
in
{
  options.${namespace}.desktop.qt = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.extraOptions.qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "adwaita-dark";
      style.package = pkgs.adwaita-qt;
    };
  };
}
