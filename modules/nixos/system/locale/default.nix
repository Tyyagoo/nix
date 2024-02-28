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
  cfg = config.system.locale;
in {
  options.system.locale = with types; {
    enable = mkBoolOpt true "Enable locale config";
    keyMap = mkOpt' str "br-abnt2";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_TIME = "pt_BR.UTF-8";
    };
    console.keyMap = mkForce cfg.keyMap;
  };
}
