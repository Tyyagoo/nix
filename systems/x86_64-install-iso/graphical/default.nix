{
    lib,
    pkgs,
    inputs,
    system,
    target,
    format,
    virtual,
    systems,
    config,
    ...
}:
with lib;
with lib.nixty;
{
  boot.loader.systemd-boot = enabled;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless = disabled;
  networking.networkmanager = enabled;

  desktop.hyprland = enabled;

  environment.systemPackages = with pkgs; [
    firefox
    neovim
    git
  ];

  system.stateVersion = "23.05";
}
