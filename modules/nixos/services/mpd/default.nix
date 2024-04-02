{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let
  cfg = config.services.mpd';
  user = config.user;
  uid = config.users.users.${user.name}.uid;
  ratesong = pkgs.writeScriptBin "ratesong" ''
    ## Usage: rate-music [0-5]

    ## Path to playlists
    playlists="${cfg.dataDir}/playlists"

    ## Prefix and suffix strings for the playlist file name
    pl_prefix='rate'
    pl_suffix='.m3u'

    ## Get current song from cmus
    song=$(mpc current -f '%file%')

    ## Error cases
    if [[ -z "$song" ]]; then
    	echo 'No song is playing.'
    	exit 1
    elif [[ "$1" -lt 0 || "$1" -gt 5 ]]; then
    	echo "Rating must be between 1 and 5. Or zero to delete the current song's rating."
    	exit 1
    fi

    ## Path to lock file
    lock="/tmp/rate-music.lock"

    ## Lock the file
    exec 9>"$lock"
    if ! flock -n 9; then
    	notify-send "Rating failed: Another instance is running."
    	exit 1
    fi

    ## Strip "file " from the output
    song=''${song/file \///}

    ## Temporary file for grepping and sorting
    tmp="$playlists/tmp.m3u"

    ## Remove the song from all rating playlists
    for n in {1..5}; do
    	f="$playlists/''${pl_prefix}$n''${pl_suffix}"
    	if [[ -f "$f" ]]; then
    		grep -vF "$song" "$f" > "$tmp"
    		mv -f $tmp $f
    	fi
    done

    ## Append the song to the new rating playlist
    if [[ $1 -ne 0 ]]; then
    	f="$playlists/''${pl_prefix}$1''${pl_suffix}"
    	mkdir -p "$playlists"
    	echo "$song" >> "$f"
    	sort -u "$f" -o "$tmp"
    	mv -f $tmp $f
    fi

    ## The lock file will be unlocked when the script ends
  '';
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
      playlistDirectory = "${cfg.dataDir}/playlists";
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

    environment.systemPackages = [ pkgs.mpc-cli pkgs.libnotify ratesong ];
  };
}
