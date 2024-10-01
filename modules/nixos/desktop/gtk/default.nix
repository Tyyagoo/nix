{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.gtk;
  inherit (lib) mkIf;
in
{
  options.${namespace}.desktop.gtk = {
    enable = mkEnableOpt;
  };

  config =
    let
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
    in
    mkIf cfg.enable {
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

      systemd.user.services.xdg-desktop-portal-gtk = {
        wantedBy = [ "xdg-desktop-portal.service" ];
        before = [ "xdg-desktop-portal.service" ];
      };

      environment.systemPackages = with pkgs; [
        brightnessctl
        gtk3
        theme.package
        cursorTheme.package
        iconTheme.package
        adwaita-icon-theme
        icon-library
      ];

      environment.variables = {
        GTK_THEME = theme.name;
      };

      home.extraOptions = {
        gtk = {
          inherit theme cursorTheme iconTheme;
          enable = true;
        };

        home = {
          pointerCursor = cursorTheme // {
            gtk.enable = true;
          };
         sessionVariables = {
            XCURSOR_THEME = cursorTheme.name;
            XCURSOR_SIZE = "${toString cursorTheme.size}";
          };
        };
      };
    };
}
