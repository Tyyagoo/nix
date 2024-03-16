{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.apps.steam;
in {
  options.apps.steam = with types; { enable = mkBoolOpt false "Enable steam"; };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession = enabled;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };

    environment.systemPackages = with pkgs; [
      lutris
      wineWowPackages.stable
      winetricks
    ];
  };
}
