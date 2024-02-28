{ lib, pkgs, inputs, system, target, format, virtual, systems, config, ... }:
with lib;
with lib.nixty; {
  imports = [ ./hardware-configuration.nix ];

  # system.boot.efi.enable = true;

  # system.battery.enable = true;

  # suites.desktop.enable = true;
  # suites.development.enable = true;
  # suites.server.enable = true;

  system.stateVersion = "23.05";
}
