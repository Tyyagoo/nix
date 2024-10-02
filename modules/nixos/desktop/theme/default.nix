{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.theme;
  inherit (lib) mkIf;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.${namespace}.desktop.theme = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ./wallpaper.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";

      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };

        sansSerif = config.stylix.fonts.serif;

        monospace = {
          package = (
            pkgs.nerdfonts.override {
              fonts = [
                "Iosevka"
              ];
            }
          );
          name = "Iosevka";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };

    };
  };
}
