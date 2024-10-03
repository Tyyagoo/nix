{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.bitwarden;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.bitwarden = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bitwarden
      bitwarden-cli
    ];
  };
}
