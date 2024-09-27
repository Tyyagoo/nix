{ self, config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.audio;
in {
  options.${namespace}.audio = {
    enable = self.lib.mkBoolOpt' false;
    lowLatency = self.lib.mkBoolOpt false "Enable low-latency setup.";
  };

  config = lib.mkIf cfg.enable {
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

    environment.systemPackages = with pkgs; [ yt-dlp pavucontrol pulsemixer ];
  };
}
