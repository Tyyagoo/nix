{ config, lib, pkgs, namespace, ... }:
with lib.${namespace};
let
  cfg = config.${namespace}.module;
  inherit (lib) mkIf;
in {
  options.${namespace}.module = { enable = mkEnableOpt; };

  config = mkIf cfg.enable {

  };
}
