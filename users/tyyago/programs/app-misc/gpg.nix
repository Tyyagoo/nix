{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ ];
    enableExtraSocket = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  programs = {
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
}
