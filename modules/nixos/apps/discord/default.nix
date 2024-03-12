{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.apps.discord;
in {
  options.apps.discord = with types; { enable = mkBoolOpt false "Enable discord"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vesktop ];
  };
}
