{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.system.shell;
  inherit (lib) mkIf types;
in
{
  options.${namespace}.system.shell = with types; {
    default = mkOpt (enum [ "nushell" ]) "nushell" "Which shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      # carapace
      starship
      zoxide
    ];

    users.defaultUserShell = pkgs.${cfg.default};
    users.users.root.shell = pkgs.bashInteractive;

    # home.programs.carapace = {
    #   enable = true;
    #   enableNushellIntegration = true;
    # };

    environment.shellAliases = {
      ".." = "cd ..";
    };

    home.programs.starship = {
      enable = true;
      enableNushellIntegration = true;
    };

    home.programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    home.programs.nushell = mkIf (cfg.default == "nushell") {
      enable = true;

      extraEnv = ''
        $env.GPG_TTY = (tty)
      '';

      extraConfig = ''
        $env.config = {
          show_banner: false,
        }
      '';
    };
  };
}
