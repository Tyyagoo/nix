{ config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.cli.gpg;
  gtk = config.${namespace}.desktop.gtk;
  fixGpg = ''
    gpgconf --launch gpg-agent
  '';
in {
  options.${namespace}.cli.gpg = { enable = lib.mkEnableOpt ""; };

  config = lib.mkIf cfg.enable {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [ ];
      enableExtraSocket = true;
      pinentryPackage =
        if gtk.enable then pkgs.pinentry-gnome3 else pkgs.pinentry-tty;
    };

    # TODO: research
    # home.packages = lib.optional config.gtk.enable pkgs.gcr;

    programs = {
      bash.profileExtra = fixGpg;
      fish.loginShellInit = fixGpg;
      zsh.loginExtra = fixGpg;
      nushell.extraLogin = fixGpg;

      gpg = {
        enable = true;
        # settings.trust-model = "tofu+pgp";

        publicKeys = [{
          source = ./public.asc;
          trust = 5;
        }];
      };
    };

    systemd.user.services = {
      # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
      # So that SSH config does not have to know the UID
      link-gnupg-sockets = {
        Unit = { Description = "link gnupg sockets from /run to /home"; };

        Service = {
          Type = "oneshot";
          ExecStart =
            "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
          ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
          RemainAfterExit = true;
        };

        Install.WantedBy = [ "default.target" ];
      };
    };
  };
}
