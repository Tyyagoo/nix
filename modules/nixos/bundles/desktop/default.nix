{ config, lib, pkgs, namespace, ... }:
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.desktop;
  inherit (lib) mkIf;
in {
  options.${namespace}.bundles.desktop = { enable = mkEnableOpt; };

  config = mkIf cfg.enable {
    "${namespace}" = {
      apps = {
        bitwarden.enable = true;
        brave.enable = true;
        discord.enable = true;
        firefox.enable = true;
      };

      system = {
        audio.enable = true;
        fonts.enable = true;
      };
    };
  };
}
