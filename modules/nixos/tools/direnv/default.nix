{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.tools.direnv;
in {
  options.tools.direnv = with types; {
    enable = mkBoolOpt false "Enable direnv";
  };

  config = mkIf cfg.enable {
    home.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
