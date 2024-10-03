{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  imports = [
    ./settings/env.nix
    ./settings/autostart.nix
    ./settings/base.nix
    ./settings/bindings.nix
  ];

  home.packages = with pkgs; [
    slurp
    grim
  ];
}
