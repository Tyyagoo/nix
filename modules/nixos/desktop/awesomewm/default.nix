{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nixty;
let
  cfg = config.desktop.awesomewm;
in {
  options.desktop.awesomewm = with types; {
    enable = mkBoolOpt false "Enable awesome window manager.";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
      };

      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
        luarocks
        ];
      };
    };
  };
}
