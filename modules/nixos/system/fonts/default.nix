{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.system.fonts;
in {
  options.system.fonts = with types; {
    enable = mkBoolOpt false "Enable custom fonts";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install";
  };

  config = mkIf cfg.enable {
    environment.variables.LOG_ICONS = "true";

    environment.systemPackages = [ pkgs.font-manager ];

    fonts.packages = with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        (nerdfonts.override { fonts = [ "Iosevka" ]; })
      ] ++ cfg.fonts;
  };
}
