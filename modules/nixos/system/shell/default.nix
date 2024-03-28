{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.system.shell;
in {
  options.system.shell = with types; {
    default = mkOpt (enum [ "nushell" ]) "nushell" "Which shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      bat
      # carapace
      eza
      nitch
      starship
      zoxide
    ];

    users.defaultUserShell = pkgs.${cfg.default};
    users.users.root.shell = pkgs.bashInteractive;

    # home.programs.carapace = {
    #   enable = true;
    #   enableNushellIntegration = true;
    # };

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
    };
  };
}
