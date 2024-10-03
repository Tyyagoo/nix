{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.direnv;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.direnv = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
