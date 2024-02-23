{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nixty;
let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland compositor.";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland = enabled;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    hardware.opengl = enabled;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = with pkgs; [
      waybar
      dunst
      libnotify
      swww
      kitty
      rofi-wayland
      busybox
    ];
  };
}
