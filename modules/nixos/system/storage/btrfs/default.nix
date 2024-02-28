{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nixty;
let
  cfg = config.system.storage.btrfs;
in {
  options.system.storage.btrfs = with types; {
    enable = mkBoolOpt false "Enable btrfs support.";
  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "btrfs" ];
    environment.systemPackages = with pkgs; [ nixty.btrfsutils ];
  };
}
