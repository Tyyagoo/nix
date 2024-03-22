{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.security.gpg;
in {
  options.security.gpg.enable = mkBoolOpt' false;

  config = mkIf cfg.enable {
    programs = {
      ssh.startAgent = false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-curses;
      };
    };

    environment.systemPackages = with pkgs; [ gnupg ];
  };
}
