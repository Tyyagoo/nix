{
  wallpaper = ./wallpapers/icy.png;

  # no config yet
  neovim = pkgs: {
    colorscheme = "gruvbox-material";

    extraPlugins = with pkgs; [
      vimPlugins.gruvbox-material
    ];

    globals = {
      gruvbox_material_better_performance = 0;
      gruvbox_material_foreground = "material";
      gruvbox_material_background = "hard";
    };
  };

  # kinda based on ashes
  palette = rec {
    scheme = "dark";

    accents = {
      primary = "blue";
      secondary = "cyan";
    };

    primary = {
      background = "#161616";
      foreground = "#edeff0";
    };

    normal = {
      black = "#2b2b2b";
      red = "#c79595";
      green = "#95c7ae";
      yellow = "#c7ae95";
      blue = "#95aec7";
      magenta = "#a58cbe";
      cyan = "#9eb7d0";
      white = "#dfe2e5";
    };

    bright = normal // {
      black = "#404040";
      white = "#f3f4f5";
    };
  };
}