{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.nix-ld;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.nix-ld = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    programs = {
      nix-ld.enable = true;
      # nix-ld.dev.enable = false;
    };
  };
}
