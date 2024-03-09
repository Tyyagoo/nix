{ options, config, lib, pkgs, inputs, system, ... }:
with lib;
with lib.nixty;
let 
  cfg = config.desktop.addons.ags;
  path = "share/com.github.Aylar.ags/types";
  pkg = inputs.ags.packages.${system}.agsWithTypes.override {
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
in {
  options.desktop.addons.ags = with types; {
    enable = mkBoolOpt false "Enable Aylur's Gtk Shell";
  };

  config = mkIf cfg.enable {
    home.file.".local/${path}".source = "${pkg}/${path}"; # type definitions
    # home.configFile."ags".source = ./config;
    environment.systemPackages = with pkgs; with nodePackages_latest; [
      pkg
      bun
      gjs
      typescript
      typescript-language-server
      eslint
      nodejs
    ];
  };
}
