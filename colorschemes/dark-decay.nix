{
  wallpaper = ./wallpapers/min_forest.png;

  neovim =
    pkgs:
    (
      let
        decay-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "decay.nvim";
          src = pkgs.decay-nvim-src;
        };
      in
      {
        extraPlugins = [ decay-nvim ];
        colorscheme = "decay-dark";
        opts.background = "dark";
      }
    );

  palette = {
    scheme = "dark";

    accents = {
      primary = "blue";
      secondary = "cyan";
    };

    primary = {
      background = "#101419";
      foreground = "#b6beca";
    };

    normal = {
      black = "#1c252c";
      red = "#e05f65";
      green = "#78dba9";
      yellow = "#f1cf8a";
      blue = "#70a5eb";
      magenta = "#c68aee";
      cyan = "#74bee9";
      white = "#dee1e6";
    };

    bright = {
      black = "#384148";
      blue = "#8cc1ff";
      cyan = "#90daff";
      green = "#94f7c5";
      magenta = "#e2a6ff";
      red = "#fc7b81";
      white = "#fafdff";
      yellow = "#ffeba6";
    };
  };
}
