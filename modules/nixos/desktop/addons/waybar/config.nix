{ }: {
  mainBar = {
    layer = "top";
    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ ];
    modules-right = [ "clock" ];

    "clock" = {
      format = "{:%I:%M %p}";
      format-alt = "{:%d/%m/%Y}";
    };
  };
}
