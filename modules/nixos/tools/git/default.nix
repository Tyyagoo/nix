{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let
  cfg = config.tools.git;
  gpg = config.security.gpg;
  user = config.user;
in {
  options.tools.git = with types; {
    enable = mkBoolOpt' true;
    userName = mkOpt' types.str user.displayName;
    userEmail = mkOpt' types.str user.email;
    signingKey =
      mkOpt types.str "D12808250532E16B" "The key ID to sign commits with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git gh lazygit ];

    home.extraOptions = {
      programs.git = {
        inherit (cfg) userName userEmail;
        enable = true;
        lfs = enabled;
        signing = {
          signByDefault = mkIf gpg.enable true;
          key = cfg.signingKey;
        };
        extraConfig = {
          init = { defaultBranch = "main"; };
          pull = { rebase = true; };
          push = { autoSetupRemote = true; };
          core = { whitespace = "trailing-space,space-before-tab"; };
        };
      };
    };
  };
}
