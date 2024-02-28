{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.system.time;
in {
  options.system.time = with types; {
    enable = mkBoolOpt true "Enable timezone configuration";
  };

  config = mkIf cfg.enable { time.timeZone = "America/Sao_Paulo"; };
}
