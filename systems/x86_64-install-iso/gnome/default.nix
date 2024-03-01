{ lib, pkgs, ... }:
with lib;
with lib.nixty; {
  networking.wireless.enable = mkForce false; # wpa_supplicant

  desktop.gnome = enabled;

  security.gpg = enabled;

  system = {
    locale = enabled;
    network = enabled;
    nix = enabled;
    time = enabled;
  };

  tools.git = enabled;

  system.stateVersion = "23.11";
}
