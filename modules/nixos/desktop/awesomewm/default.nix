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
        package = pkgs.awesome-git;
        luaModules = with pkgs.luaPackages; [
          luarocks
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      wezterm
      rofi
      acpi
      acpid
      upower
      lxappearance
      jq
      inotify-tools
      polkit_gnome
      xdotool
      xclip
      gpick
      ffmpeg
      blueman
      redshift
      pipewire
      alsa-utils
      brightnessctl
      feh 
      maim
      mpv
      mpd
      mpc-cli
      mpdris2
      python311Packages.mutagen
      ncmpcpp
      playerctl
    ];

    # home.file = {
    #   ".config/awesome" = {
    #     recursive = true;
    #     source = ./config;
    #   };
    # };

    nix.settings.substituters = [
      "https://cache.nixos.org?priority=10"
      "https://fortuneteller2k.cachix.org"
    ];
  };
}
