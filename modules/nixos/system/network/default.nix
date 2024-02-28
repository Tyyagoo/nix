{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.system.network;
in {
  options.system.network = with types; {
    enable = mkBoolOpt false "Enable Network Manager.";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    environment.persist.directories = [ "/etc/NetworkManager" ];
  };
}
