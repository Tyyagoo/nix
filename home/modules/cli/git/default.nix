{ config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.cli.git;
  hasGpg = config.${namespace}.cli.gpg.enable;
in {
  options.${namespace}.cli.git = {
    enable = lib.mkEnableOpt "";
    userName = lib.mkOpt lib.types.str "Tyyagoo" "";
    userEmail = lib.mkOpt lib.types.str "tyyago.dev@gmail.com" "";
    signingKey = lib.mkOpt lib.types.str "D12808250532E16B"
      "The key ID to sign commits with.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ gh ];

    programs = {
      git = {
        inherit (cfg) userName userEmail;

        enable = true;
        lfs.enable = true;

        signing = {
          signByDefault = hasGpg;
          key = cfg.signingKey;
        };

        extraConfig = {
          init = { defaultBranch = "main"; };
          pull = { rebase = true; };
          push = { autoSetupRemote = true; };
          core = { whitespace = "trailing-space,space-before-tab"; };
        };

        ignores = [ ".direnv" "result" ];
      };

      lazygit = { enable = true; };

      gh = {
        enable = true;
        extensions = with pkgs; [ gh-markdown-preview ];
        settings = {
          git_protocol = "ssh";
          prompt = "enabled";
        };
      };

      gh-dash = { enable = true; };
    };
  };
}
