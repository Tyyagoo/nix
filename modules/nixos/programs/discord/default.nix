{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.discord;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.discord = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vesktop
      xwaylandvideobridge
    ];
  };
}
