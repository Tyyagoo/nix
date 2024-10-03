{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.gpg;
  hasGtk = config.${namespace}.desktop.gtk.enable;
  user = config.user;
  fixGpg = ''
    gpgconf --launch gpg-agent
  '';
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.gpg = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [ ];
      enableExtraSocket = true;
      pinentryPackage = if hasGtk then pkgs.pinentry-gnome3 else pkgs.pinentry-tty;
    };

    # TODO: research
    # home.packages = lib.optional config.gtk.enable pkgs.gcr;

    home.programs = {
      bash.profileExtra = fixGpg;
      fish.loginShellInit = fixGpg;
      zsh.loginExtra = fixGpg;
      nushell.extraLogin = fixGpg;

      gpg = {
        enable = true;
        # settings.trust-model = "tofu+pgp";

        publicKeys = [
          {
            source = ./public.pgp;
            trust = 5;
          }
        ];
      };
    };

    # systemd.user.services = {
    #   # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    #   # So that SSH config does not have to know the UID
    #   link-gnupg-sockets = {
    #     Unit = { Description = "link gnupg sockets from /run to /home"; };
    # 
    #     Service = {
    #       Type = "oneshot";
    #       ExecStart =
    #         "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
    #       ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
    #       RemainAfterExit = true;
    #     };
    # 
    #     Install.WantedBy = [ "default.target" ];
    #   };
    # };
  };
}
