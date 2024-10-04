{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.gtk;
  inherit (lib) mkIf;
in {
  options.${namespace}.desktop.gtk = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    #
    # systemd.user.services.xdg-desktop-portal-gtk = {
    #   wantedBy = [ "xdg-desktop-portal.service" ];
    #   before = [ "xdg-desktop-portal.service" ];
    # };

    environment.systemPackages = with pkgs; [
      brightnessctl
      gtk3
      icon-library
    ];
  };
}
