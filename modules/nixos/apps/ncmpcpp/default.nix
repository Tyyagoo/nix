{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.apps.ncmpcpp;
in {
  options.apps.ncmpcpp = with types; { enable = mkBoolOpt' false; };

  config = mkIf cfg.enable {
    home.programs.ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override { visualizerSupport = true; };
      bindings = [
        {
          key = "j";
          command = "scroll_down";
        }
        {
          key = "k";
          command = "scroll_up";
        }
      ];
      settings = {
        mpd_host = "127.0.0.1";
        mpd_port = "6600";
        lyrics_directory = "/storage/ncmpcpp/lyrics";
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "mpfifo";
        visualizer_in_stereo = "yes";
        visualizer_type = "spectrum";
        visualizer_look = "+|";
      };
    };
  };
}
