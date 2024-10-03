{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.brave;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.brave = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable { environment.systemPackages = [ pkgs.brave ]; };
}
