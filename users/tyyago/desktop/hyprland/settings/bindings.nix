{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bind = let
      utils = import ./utils.nix {inherit pkgs lib;};
      num-workspaces = 7;

      workspaces = let
        generator = x: let
          ws = let
            c = (x + 1) / num-workspaces;
          in
            builtins.toString (x + 1 - (c * num-workspaces));
        in [
          "SUPER, ${ws}, workspace, ${toString (x + 1)}"
          "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ];
      in
        builtins.concatLists (builtins.genList generator num-workspaces);

      reloadAgs = utils.silentScript "reload-ags" ''
        pgrep -x .ags-wrapped > /dev/null 2>&1 && kill -9 $(pgrep -x .ags-wrapped)
        ags & disown
      '';
    in
      workspaces
      ++ [
        "SUPERSHIFT, Q, exit"
        "SUPER, W, killactive"
        "SUPER, S, togglesplit"
        "SUPER, F, fullscreen"
        "SUPER, P, pseudo"
        "SUPERSHIFT, P, pin"
        "SUPER, Space, togglefloating"

        # utils scripts
        "SUPER SHIFT, R, exec, ${reloadAgs}"

        # move focus
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        # Move windows
        "SUPERSHIFT, H, movewindow, l"
        "SUPERSHIFT, L, movewindow, r"
        "SUPERSHIFT, K, movewindow, u"
        "SUPERSHIFT, J, movewindow, d"

        # Utilities
        "SUPER, Return, exec, ${pkgs.alacritty}/bin/alacritty"
        "SUPERSHIFT, Return, exec, ${pkgs.wofi}/bin/wofi --show drun"
      ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
