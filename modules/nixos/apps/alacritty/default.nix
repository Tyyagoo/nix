{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.apps.alacritty;
  inherit (lib) mkForce mkIf types;
in
{
  options.${namespace}.apps.alacritty = with types; {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.programs.alacritty = {
      enable = true;

      settings = {
        env.TERM = "alacritty";
        cursor.style = "block";
        shell.program = "/run/current-system/sw/bin/nu";
        mouse.hide_when_typing = true;

        colors.draw_bold_text_with_bright_colors = true;

        window = {
          padding = {
            x = 30;
            y = 20;
          };
        };

        bell = {
          animation = "EaseOutExpo";
          duration = 5;
          color = "#e4c9af";
        };

        font = {
          normal = mkForce {
            family = "Iosevka Nerd Font Mono";
            style = "Regular";
          };

          bold = mkForce {
            family = "Iosevka Nerd Font Mono";
            style = "Bold";
          };

          italic = mkForce {
            family = "Iosevka NF";
            style = "Italic";
          };

          bold_italic = mkForce {
            family = "Iosevka NF";
            style = "Bold Italic";
          };

          glyph_offset = {
            x = 0;
            y = 0;
          };
        };
      };
    };
  };
}
