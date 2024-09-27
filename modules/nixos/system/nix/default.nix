{ config, lib, pkgs, namespace, ... }:
with lib.${namespace};
let
  cfg = config.${namespace}.system.nix;
  inherit (lib) mkIf types;
in {
  options.${namespace}.system.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package =
      mkOpt types.package pkgs.nixVersions.latest "Which package to use.";
    extraUsers = mkOpt (listOf str) [ ] "Extra users to trust";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nil
      nixfmt-rfc-style
      nix-index
      nix-prefetch-git
      nix-output-monitor
    ];

    nix = let users = [ "root" config.user.name ];
    in {
      inherit (cfg) package;

      settings = {
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = users ++ cfg.extraUsers;
        allowed-users = users;
      } // (lib.optionalAttrs config.${namespace}.tools.direnv.enable {
        keep-outputs = true;
        keep-derivations = true;
      });

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };

}
