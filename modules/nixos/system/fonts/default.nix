{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.system.fonts;
  inherit (lib) mkIf types;
in
{
  options.${namespace}.system.fonts = with types; {
    enable = mkEnableOpt;
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install";
  };

  config = mkIf cfg.enable {
    environment.variables.LOG_ICONS = "true";

    environment.systemPackages = [ pkgs.font-manager ];

    fonts.packages =
      with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
      ]
      ++ cfg.fonts;
  };
}
