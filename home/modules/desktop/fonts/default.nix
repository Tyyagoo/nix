{ config, lib, pkgs, namespace, ... }:
let cfg = config.${namespace}.desktop.fonts;
in {
  options.${namespace}.desktop.fonts = { enable = lib.mkEnableOpt ""; };

  config = lib.mkIf cfg.enable {
    fontProfiles = {
      enable = true;
      monospace = {
        name = "FiraCode Nerd Font";
        package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
      };
      regular = {
        name = "Fira Sans";
        package = pkgs.fira;
      };
    };
  };
}
