{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      userName = "Tyyagoo";
      userEmail = "tyyago.dev@gmail.com";

      signing = {
        signByDefault = true;
        key = "D12808250532E16B";
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
}
