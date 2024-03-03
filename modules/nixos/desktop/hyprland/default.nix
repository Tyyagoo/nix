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
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = [ pkgs.kitty ];
  };
}
