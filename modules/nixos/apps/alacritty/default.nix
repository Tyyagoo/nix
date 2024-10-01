{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.apps.alacritty;
  inherit (lib) mkIf types;
in
{
  options.${namespace}.apps.alacritty = with types; {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ alacritty ];

    home.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  };
}
