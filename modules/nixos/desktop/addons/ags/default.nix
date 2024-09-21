{ options, config, lib, pkgs, inputs, system, ... }:
with lib;
with lib.nixty;
let
  cfg = config.desktop.addons.ags;
  ags = inputs.ags.packages.${system}.default;
  astal = inputs.ags.packages.${system}.astal;
in {
  options.desktop.addons.ags = with types; {
    enable = mkBoolOpt false "Enable Aylur's Gtk Shell";
  };

  config = mkIf cfg.enable {
    home.file.".local/share/ags".source = "${astal}/share/astal/gjs";
    environment.systemPackages = with pkgs;
      with nodePackages_latest; [
        ags
	astal
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
