{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.system.nix;
in {
  options.system.nix = with types; {
    enable = mkBoolOpt true "Enable nix configuration";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nixfmt nix-output-monitor ];

    nix = let users = [ "root" config.user.name ];
    in {
      settings = {
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        # sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = users;
        allowed-users = users;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
