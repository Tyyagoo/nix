{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.common;
  inherit (lib) mkIf;
in
{
  options.${namespace}.bundles.common = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bat
      bc
      bottom
      diffsitter
      eza
      fd
      fzf
      httpie
      jq
      ncdu
      nitch
      pfetch-rs
      ripgrep
      timer
    ];

    home.sessionVariables = {
      PF_INFO = "ascii title os kernel uptime shell de palette";
    };

    "${namespace}" = {
      programs = {
        direnv.enable = true;
        git.enable = true;
        gpg.enable = true;
        nix-ld.enable = true;
      };

      system = {
        boot.efi.enable = true;
        nix.enable = true;
      };
    };
  };
}
