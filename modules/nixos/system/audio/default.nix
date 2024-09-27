{ config, lib, pkgs, namespace, ... }:
with lib.${namespace};
let
  cfg = config.${namespace}.system.audio;
  inherit (lib) mkIf;
in {
  options.${namespace}.system.audio = {
    enable = mkEnableOpt;
    lowLatency = mkBoolOpt false "Enable low-latency setup.";
  };

  config = mkIf cfg.enable {
    # sound.enable = true;
    # hardware.pulseaudio = {
    #   enable = true;
    #   support32Bit = true;
    # };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      ffmpeg
      yt-dlp
      pavucontrol
      pulsemixer
    ];
  };
}
