{ config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.desktop.gtk;
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
in {
  options.${namespace}.desktop.gtk = { enable = lib.mkEnableOpt ""; };

  config = lib.mkIf cfg.enable {
    gtk = {
      inherit theme cursorTheme iconTheme;
      enable = true;
    };

    home.packages = with pkgs; [
      brightnessctl
      adwaita-icon-theme
      icon-library
    ];

    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
