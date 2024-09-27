{ config, lib, pkgs, namespace, ... }:
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.gtk;
  inherit (lib) mkIf;
in {
  options.${namespace}.desktop.gtk = { enable = mkEnableOpt; };

  config = mkIf cfg.enable { };
}
