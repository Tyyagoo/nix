{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let
  cfg = config.services.mpd';
  user = config.user;
  uid = config.users.users.${user.name}.uid;
in {
  options.services.mpd' = with types; {
    enable = mkBoolOpt false "Enable Music Player Daemon.";
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      dataDir = "/storage/mpd";
      startWhenNeeded = true;
      extraConfig = ''
                auto_update "yes"

                audio_output {
        	  type "pipewire"
        	  name "Pipewire Sound Server"
        	}

		audio_output {
		  type "fifo"
		  name "mpfifo"
		  path "/tmp/mpd.fifo"
		  format "44100:16:2"
		}
      '';
    };

    systemd.services.mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/${toString uid}";
    };

    environment.systemPackages = with pkgs; [ mpc-cli ];
  };
}