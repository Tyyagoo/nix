{ config, lib, pkgs, namespace, ... }:
with lib.${namespace};
let
  cfg = config.${namespace}.apps.brave;
  inherit (lib) mkIf;
in {
  options.${namespace}.apps.brave = { enable = mkEnableOpt; };

  config = mkIf cfg.enable { environment.systemPackages = [ pkgs.brave ]; };
}
