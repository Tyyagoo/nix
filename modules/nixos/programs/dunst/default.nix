{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.programs.dunst;
  inherit (lib) mkIf;
in
{
  options.${namespace}.programs.dunst = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.services.dunst = {
      enable = true;

      settings = {
        global = {
          monitor = 0;
          follow = "none";
          width = 450;
          height = 200;
          origin = "top-right";
          offset = "30x30";
          scale = 0;
          notification_limit = 5;
          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 0;
          progress_bar_min_width = 420;
          progress_bar_max_width = 420;
          indicate_hidden = true;
          separator_height = 2;
          padding = 15;
          horizontal_padding = 15;
          text_icon_padding = 25;
          frame_width = 2;
          frame_color = "#7e9cd8";
          separator_color = "frame";
          sort = "yes";
          idle_threshold = 300;
          font = "Monospace 13";
          line_height = 0;
          markup = "full";
          format = "<i>%s</i>\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 60;
          ellipsize = "middle";
          ignore_newline = "no";
          stack_duplicates = false;
          hide_duplicate_count = true;
          show_indicators = "yes";
          enable_recursive_icon_lookup = true;
          icon_theme = "Adwaita";
          icon_position = "left";
          min_icon_size = 32;
          max_icon_size = 96;
          icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";
          sticky_history = "yes";
          history_length = 20;
          dmenu = "/usr/local/bin/rofi -dmenu -p dunst:";
          browser = "/usr/bin/xdg-open";
          always_run_script = true;
          title = "Dunst";
          class = "Dunst";
          corner_radius = 15;
          ignore_dbusclose = false;
          force_xwayland = false;
          force_xinerama = false;
          mouse_left_click = "do_action";
          mouse_middle_click = "close_current";
          mouse_right_click = "close_all";
        };

        experimental = {
          per_monitor_dpi = false;
        };

        urgency_low = {
          background = "#1f1f28";
          foreground = "#dcd7ba";
          frame_color = "#7e9cd8";
          timeout = 10;
        };

        urgency_normal = {
          background = "#1f1f28";
          foreground = "#dcd7ba";
          highlight = "#7e9cd8";
          timeout = 10;
        };

        urgency_critical = {
          background = "#1f1f28";
          foreground = "#dcd7ba";
          frame_color = "#7e9cd8";
          timeout = 0;
        };

        brightness = {
          summary = " Light";
          history_ignore = "yes";
          set_stack_tag = "light";
        };

        music = {
          desktop_entry = "spotify";
          history_ignore = "yes";
          set_stack_tag = "music";
        };
      };
    };
  };
}
