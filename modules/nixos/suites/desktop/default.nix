{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.suites.desktop;
in {
  options.suites.desktop = with types; { enable = mkBoolOpt' false; };

  config = mkIf cfg.enable {
    desktop.hyprland = enabled;
    # desktop.gnome = enabled;

    apps = {
      alacritty = enabled;
      bitwarden = enabled;
      discord = enabled;
      firefox = enabled;
    };

    environment.systemPackages = with pkgs; [ appimage-run ];
  };
}
