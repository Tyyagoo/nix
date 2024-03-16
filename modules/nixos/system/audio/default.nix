{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.system.audio;
in {
  options.system.audio = with types; {
    enable = mkBoolOpt false "Enable audio support.";
    lowLatency = mkBoolOpt false "Enable low-latency setup.";
  };

  config = mkIf cfg.enable {
    # sound.enable = true;
    # hardware.pulseaudio = {
    #   enable = true;
    #   support32Bit = true;
    # };

    # security.rtkit = enabled;
    # services.pipewire = {
    #   enable = true;
    #   alsa.enable = true;
    #   alsa.support32Bit = true;
    #   pulse.enable = true;
    #   wireplumber.enable = true;
    # };

    environment.systemPackages = with pkgs; [ yt-dlp pavucontrol pulsemixer ];

    # TODO: optimize the quant value
    environment.etc = let json = pkgs.formats.json { };
    in mkIf cfg.lowLatency {
      "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
        context.properties = {
          default.clock.rate = 48000
          default.clock.quantum = 32
          default.clock.min-quantum = 32
          default.clock.max-quantum = 32
        }
      '';

      # NOTE: As a general rule, the values in pipewire-pulse should not be lower than the ones in pipewire. 
      "pipewire/pipewire-pulse.d/92-low-latency.conf".source =
        json.generate "92-low-latency.conf" {
          context.modules = [{
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "32/48000";
              pulse.max.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "32/48000";
            };
          }];
          stream.properties = {
            node.latency = "32/48000";
            resample.quality = 1;
          };
        };

      "wireplumber/main.lua.d/99-alsa-lowlatency.lua".text = ''
        alsa_monitor.rules = {
          {
            matches = {{{ "node.name", "matches", "alsa_output.*" }}};
            apply_properties = {
              ["audio.format"] = "S32LE",
              ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
              ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
              -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
            },
          },
        }
      '';
    };
  };
}
