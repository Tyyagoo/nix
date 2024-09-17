{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.apps.alacritty;
in {
  options.apps.alacritty = with types; {
    enable = mkBoolOpt false "Enable alacritty";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ alacritty ];

    home.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  };
}
