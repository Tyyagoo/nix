{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.module;
in {
  options.module = with types; { enable = mkBoolOpt true "Only disable on headless!"; };

  config = let
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      name = "Qogir";
      size = 24;
      package = pkgs.qogir-icon-theme;
    };
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    }; 
  in mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
      gtk3
      theme.package
      cursorTheme.package
      iconTheme.package
      gnome.adwaita-icon-theme
      icon-library
    ];

    environment.variables = {
      GTK_THEME = theme.name;
    };

    home.extraOptions = {
      gtk = enabled // { inherit theme cursorTheme iconTheme; };
      home = {
        pointerCursor = cursorTheme // { gtk = enabled; };
        sessionVariables = {
          XCURSOR_THEME = cursorTheme.name;
          XCURSOR_SIZE = "${toString cursorTheme.size}";
        };
      };
    };
  };
}
