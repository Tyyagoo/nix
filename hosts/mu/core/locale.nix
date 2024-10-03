{ lib, ... }:
let
  systemLanguage = "en_US";
  systemFormat = "pt_BR";
  keyMap = "br-abnt2";
in
{
  i18n.defaultLocale = "${systemLanguage}.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${systemFormat}.UTF-8";
    LC_IDENTIFICATION = "${systemFormat}.UTF-8";
    LC_MEASUREMENT = "${systemFormat}.UTF-8";
    LC_MONETARY = "${systemFormat}.UTF-8";
    LC_NAME = "${systemFormat}.UTF-8";
    LC_NUMERIC = "${systemFormat}.UTF-8";
    LC_PAPER = "${systemFormat}.UTF-8";
    LC_TELEPHONE = "${systemFormat}.UTF-8";
    LC_TIME = "${systemFormat}.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce keyMap;
  };
}
