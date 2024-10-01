{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.tools.git;
  hasGpg = config.${namespace}.tools.gpg.enable;
  user = config.user;
  inherit (lib) mkIf types;
in
{
  options.${namespace}.tools.git = {
    enable = mkEnableOpt;
    userName = mkOpt' types.str user.displayName;
    userEmail = mkOpt' types.str user.email;
    signingKey = mkOpt types.str "D12808250532E16B" "The key ID to sign commits with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];
    home.packages = with pkgs; [ commitizen ];

    home.programs = {
      git = {
        inherit (cfg) userName userEmail;

        enable = true;
        lfs.enable = true;

        signing = {
          signByDefault = hasGpg;
          key = cfg.signingKey;
        };

        extraConfig = {
          init = {
            defaultBranch = "main";
          };
          pull = {
            rebase = true;
          };
          push = {
            autoSetupRemote = true;
          };
          core = {
            whitespace = "trailing-space,space-before-tab";
          };
        };

        ignores = [
          ".direnv"
          "result"
        ];
      };

      lazygit = {
        enable = true;
      };

      gh = {
        enable = true;
        extensions = with pkgs; [ gh-markdown-preview ];
        settings = {
          git_protocol = "ssh";
          prompt = "enabled";
        };
      };

      gh-dash = {
        enable = true;
      };
    };
  };
}
