{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.system.fonts;
  inherit (lib) mkIf types;
in
{
  options.${namespace}.system.fonts = with types; {
    enable = mkEnableOpt;
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install";
  };

  config = mkIf cfg.enable {
    environment.variables.LOG_ICONS = "true";

    environment.systemPackages = [ pkgs.font-manager ];

    fonts = {
      enableDefaultPackages = false;

      packages =
        with pkgs;
        [
          inter
          noto-fonts
          noto-fonts-cjk
          noto-fonts-color-emoji
          (nerdfonts.override {
            fonts = [
              "Iosevka"
              "JetBrainsMono"
              "Noto"
            ];
          })
        ]
        ++ cfg.fonts;

      fontconfig = {
        hinting.style = "full";
        subpixel.rgba = "rgb";

        defaultFonts = rec {
          serif = [ "Noto Serif" "Noto Nerd Font" ];
          sansSerif = serif;
          monospace = [ "Iosevka Nerd Font Mono" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
