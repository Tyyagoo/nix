{ self, config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.locale;
in {
  options.${namespace}.locale = {
    systemLanguage = self.lib.mkStrOpt' "en_US";
    systemFormat = self.lib.mkStrOpt' "pt_BR";
    keyMap = self.lib.mkStrOpt' "br-abnt2";
  };

  config = {
    i18n.defaultLocale = "${cfg.systemLanguage}.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "${cfg.systemFormat}.UTF-8";
      LC_IDENTIFICATION = "${cfg.systemFormat}.UTF-8";
      LC_MEASUREMENT = "${cfg.systemFormat}.UTF-8";
      LC_MONETARY = "${cfg.systemFormat}.UTF-8";
      LC_NAME = "${cfg.systemFormat}.UTF-8";
      LC_NUMERIC = "${cfg.systemFormat}.UTF-8";
      LC_PAPER = "${cfg.systemFormat}.UTF-8";
      LC_TELEPHONE = "${cfg.systemFormat}.UTF-8";
      LC_TIME = "${cfg.systemFormat}.UTF-8";
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = lib.mkForce cfg.keyMap;
    };
  };
}
