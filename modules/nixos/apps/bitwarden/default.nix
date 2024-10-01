{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.apps.bitwarden;
  inherit (lib) mkIf;
in
{
  options.${namespace}.apps.bitwarden = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bitwarden
      bitwarden-cli
    ];
  };
}
