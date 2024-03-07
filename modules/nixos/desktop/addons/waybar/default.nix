{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let
  cfg = config.desktop.addons.waybar;
  waybar-restart = pkgs.writeShellApplication {
    name = "waybar-restart";
    runtimeInputs = [ pkgs.busybox ];
    text = ''
      killall -q waybar
      waybar &
    '';
  };
in {
  options.desktop.addons.waybar = with types; {
    enable = mkBoolOpt false "Enable waybar";
  };

  config = mkIf cfg.enable {
    home.programs.waybar = {
      enable = true;
      settings = import ./config.nix { inherit pkgs; };
      style = import ./style.nix { };
    };

    environment.systemPackages = [ waybar-restart pkgs.cava ];
  };
}
