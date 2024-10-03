{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.hyprland;
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  inherit (lib) mkIf;
in
{
  options.${namespace}.desktop.hyprland = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    xdg.portal.xdgOpenUsePortal = true;

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      wl-clipboard
      hyprpicker
      wf-recorder
      wayshot
      slurp
      swappy
      swww
    ];

    home.extraOptions.wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;

      settings = {
        env = [
          # "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "GDK_BACKEND,wayland,x11"
          "QT_QPA_PLATFORM,wayland"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "XDG_SESSION_TYPE,wayland"
          "VISUAL,nvim"
          "EDITOR,nvim"
        ];

        exec-once = [
          "swww init"
          "waybar"
          # "hyprctl setcursor Qogir 24"
        ];

        monitor = [ ",preferred,auto,1" ];

        general = {
          layout = "dwindle";
          resize_on_border = true;
        };

        cursor = {
          no_warps = true;
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_splash_rendering = true;
        };

        input = {
          kb_layout = "br";
          kb_model = "abnt2";
          kb_options = "caps:swapescape";
          numlock_by_default = true;
          sensitivity = 0;
        };

        windowrule =
          let
            f = regex: "float, ^(${regex})$";
          in
          [
            (f "float")
            (f "Picture-in-Picture")
            (f "com.github.Aylur.ags")
          ];

        bind =
          let
            binding =
              mod: cmd: key: arg:
              "${mod}, ${key}, ${cmd}, ${arg}";
            mvfocus = binding "SUPER" "movefocus";
            mvtows = binding "SUPER SHIFT" "movetoworkspace";
            ws = binding "SUPER" "workspace";
            ags = "exec, ags";
            workspaces = [
              1
              2
              3
              4
              5
              6
              7
              8
              9
            ];
          in
          [
            "SUPER, SUPER_L, ${ags} -t launcher"
            "SUPER, Tab,     ${ags} -t overview"
            ",XF86PowerOff,  ${ags} -r 'powermenu.shutdown()'"
            ",XF86Launch4,   ${ags} -r 'recorder.start()'"
            ",Print,         ${ags} -r 'recorder.screenshot()'"
            "SHIFT,Print,    ${ags} -r 'recorder.screenshot(true)'"

            "SUPER, Return, exec, alacritty"
            "SUPER, W, exec, firefox"

            "CTRL ALT, Delete, exit"
            "CTRL SHIFT, R, exec, hyprctl reload"
            "ALT, Q, killactive"
            "ALT, Tab, focuscurrentorlast"
            "SUPER, F, togglefloating"
            "SUPER, G, fullscreen"
            "SUPER, O, fullscreenstate, -1 2"
            "SUPER, P, togglesplit"

            (mvfocus "k" "u")
            (mvfocus "j" "d")
            (mvfocus "l" "r")
            (mvfocus "h" "l")
          ]
          ++ (map (i: ws (toString i) (toString i)) workspaces)
          ++ (map (i: mvtows (toString i) (toString i)) workspaces);

        bindl = [
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];

        bindel = [
          ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
          ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
          ",XF86AudioRaiseVolume,  exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,  exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        bindm = [
          "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
        ];

        decoration = {
          drop_shadow = "yes";
          shadow_range = 8;
          shadow_render_power = 2;
          # "col.shadow" = "rgba(00000044)";

          dim_inactive = false;

          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            new_optimizations = "on";
            noise = 1.0e-2;
            contrast = 0.9;
            brightness = 0.8;
            popups = true;
          };
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 5, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
      };
    };
  };
}
