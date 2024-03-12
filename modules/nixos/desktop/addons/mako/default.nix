{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.desktop.addons.mako;
in {
  options.desktop.addons.mako = with types; { enable = mkBoolOpt false "Enable mako"; };

  config = mkIf cfg.enable {
    home.services.mako = {
      enable = true;
    };
  };
}
