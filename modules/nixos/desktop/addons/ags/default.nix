{ options, config, lib, pkgs, inputs, system, ... }:
with lib;
with lib.nixty;
let
  cfg = config.desktop.addons.ags;
  astal = inputs.ags.packages.${system}.astal;
  pkg = inputs.ags.packages.${system}.default.override {
    inherit (astal)
    ;
    extraPackages = with inputs.ags.packages.${system}; [
      apps
      auth
      battery
      hyprland
      mpris
      network
      notifd
      tray
      wireplumber
    ];
    astalGjs = "/home/${config.user.name}/.local/share/ags";
  };
in {
  options.desktop.addons.ags = with types; {
    enable = mkBoolOpt false "Enable Aylur's Gtk Shell";
  };

  config = mkIf cfg.enable {
    home.file.".local/share/ags".source = "${astal}/share/astal/gjs";
    environment.systemPackages = with pkgs;
      with nodePackages_latest;
      [
        pkg
        # bun
        # gjs
        # typescript
        # typescript-language-server
        # eslint
        # nodejs
        # dart-sass
        # fd
        # fzf
      ];
  };
}
