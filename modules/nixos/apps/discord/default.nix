{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.apps.discord;
  inherit (lib) mkIf;
in
{
  options.${namespace}.apps.discord = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vesktop
      xwaylandvideobridge
    ];
  };
}
