{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.apps.bitwarden;
in {
  options.apps.bitwarden = with types; { enable = mkBoolOpt false "Enable bitwarden"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bitwarden
      bitwarden-cli
    ];
  };
}
