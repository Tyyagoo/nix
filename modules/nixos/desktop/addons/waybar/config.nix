{ }: {
  mainBar = {
    layer = "top";
    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ ];
    modules-right = [ "clock" ];

    "hyprland/workspaces" = { persistent-workspaces = { "*" = 9; }; };

    "clock" = {
      format = ''
        {:%r
        %A, %d/%b}'';
      tooltip = true;
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        on-scroll = 1;
        on-click-right = "mode";
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
    };
  };
}
