{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let
  cfg = config.services.mpd';
  user = config.user;
  uid = config.users.users.${user.name}.uid;
in {
  options.services.mpd' = with types; {
    enable = mkBoolOpt' false;
    dataDir = mkOpt' str "/storage/mpd";
  };

  config = mkIf cfg.enable {

    home.services.mpd = {
      inherit (cfg) dataDir;
      enable = true;
      musicDirectory = "${cfg.dataDir}/music";
      network.startWhenNeeded = true;
      extraConfig = ''
        audio_output {
          type "pulse"
          name "pulseaudio"
        }

        audio_output {
          type "fifo"
          name "mpfifo"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
      extraArgs = [ "--verbose" ];
    };

    home.services.mpd-mpris = enabled;

    environment.systemPackages = [ pkgs.mpc-cli ];
  };
}
