{ config, lib, pkgs, namespace, ... }:
let cfg = config.${namespace}.cli.direnv;
in {
  options.${namespace}.cli.direnv = { enable = lib.mkEnableOpt ""; };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
