{
  wallpaper = ./wallpapers/fantasy-woods.png;

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
        colorscheme = "decay";
        opts.background = "light";
      }
    );

  palette = rec {
    scheme = "light";

    accents = {
      primary = "green";
      secondary = "blue";
    };

    primary = {
      background = "#dee1e6";
      foreground = "#101419";
    };

    normal = {
      black = "#c5c8cd";
      red = "#903035";
      green = "#3c6843";
      yellow = "#a08652";
      blue = "#234d87";
      magenta = "#7f529d";
      cyan = "#417998";
      white = "#101419";
    };

    bright = {
      black = "#989ba0";
      blue = "#3e6699";
      cyan = "#417998";
      green = "#538b5b";
      magenta = "#7f529d";
      red = "#903035";
      white = "#1f2328";
      yellow = "#a08652";
    };
  };
}
