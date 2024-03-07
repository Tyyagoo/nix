{ pkgs, ... }: 
  {
  mainBar = {
    layer = "top";
    modules-left = [ "custom/launcher" "idle_inhibitor" "mpd" "cava" "pulseaudio" ];
    modules-center = [ "hyprland/workspaces" ];
    modules-right = [ "network" "cpu" "memory" "tray" "clock" "custom/powermenu" ];

    "custom/launcher" = {
      format = "󱄅";
      on-click = "waybar-restart";
      tooltip = false;
    };

    "idle_inhibitor" = {
      format = "{icon}";
      tooltip = false;
      format-icons = {
        activated = "󰒳";
        deactivated = "󰒲";
      };
    };

    "pulseaudio" = {
      format = " {icon} {volume}%"; 
      format-muted = "󰝟 Muted";
      format-icons = {
        default = ["" "󰖀" "󰕾"];
      };
      states = {
        normal = 60;
        warning = 80;
        critical = 120;
      };
      on-click = "pulsemixer --toggle-mute";
      on-click-right = "kitty --class float -e pulsemixer";
      tooltip = false;
    };

    "mpd" = {
      format = "󰏤 {title}";
      format-paused = "󰐊 {title}";
      format-stopped = "󰝚 Play";
      format-disconnected = ""; # go away
      on-click = "mpc --quiet toggle";
      on-click-right = "mpc ls | mpc add";
      on-click-middle = "kitty -e ncmpcpp";
      on-scroll-up = "mpc --quiet prev";
      on-scroll-down = "mpc --quiet next";
      smooth-scrolling-threshold = 5;
      tooltip-format = "󰝚 {title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
    };

    "cava" = {
      framerate = 30;
      autosens = 1;
      bars = 14;
      lower_cutoff_freq = 50;
      higher_cutoff_freq = 10000;
      method = "pulse";
      source = "auto";
      stereo = true;
      reverse = false;
      bar_delimiter = 0;
      monstercat = false;
      waves = false;
      noise_reduction = 0.77;
      input_delay = 4;
      format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ]; 
      actions = {
        on-click-right = "mode";
      };
    };

    "hyprland/workspaces" = { 
      format = "{icon}";
      format-icons = {
        active = " ";
        default = " ";
      };
      # persistent-workspaces = { "*" = 9; };
    };

    "network" = {
      format = "{icon}";
      format-wifi = "󰖩 {essid} ({signalStrength}%)";
      format-ethernet = "󰖟 {ifname} ({ipaddr})";
      format-disconnected = "󰌙 Disconnected";
      tooltip-format = "󰥔  {frequency} 󰅧  {bandwidthUpBits}   {bandwidthDownBits}";
    };

    "cpu" = {
      format = " {usage}%";
      interval = 1;
    };

    "memory" = {
      format = "󰪶 {percentage}%";
      format-tooltip = "{used:0.2f}GiB used";
      interval = 300;
    };

    "tray" = {
      icon-size = 15;
      spacing = 5;
    };

    "clock" = {
      format = "{:  %H:%M %p   %A %d %b}";
    };

    "custom/powermenu" = {
      format = "󰐥";
      tooltip = false;
    };
  };
}
