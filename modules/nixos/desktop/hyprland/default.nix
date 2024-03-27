{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland compositor";
  };

  config = mkIf cfg.enable {
    programs.hyprland = enabled;
    programs.thunar = enabled;

    desktop.addons = { 
      ags = enabled;
      mako = enabled;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    home.configFile = {
      "hypr/hyprland.conf" = {
        text = import ./config.nix { };
        onChange = "hyprctl reload";
      };
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    systemd.user.services.xdg-desktop-portal-gtk = {
      wantedBy = [ "xdg-desktop-portal.service" ];
      before = [ "xdg-desktop-portal.service" ];
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      hyprpicker
      wf-recorder
      wayshot
      swappy
      swww
      wofi
    ];
  };
}
