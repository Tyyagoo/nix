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
  cfg = config.hardware.storage.btrfs;
in {
  options.hardware.storage.btrfs = with types; {
    enable = mkBoolOpt false "Enable btrfs support.";
  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "btrfs" ];

    scripts = {
      diff = pkgs.writeShellApplication {
        name = "btrfs-diff";
        runtimeInputs = with pkgs; [];
        text = ''
          OLD_TRANSID=''$(sudo btrfs subvolume find-new /mnt/root-blank 9999999)
          OLD_TRANSID=''${OLD_TRANSID#transid marker was }

          sudo btrfs subvolume find-new "/mnt/root" "$OLD_TRANSID" |
          sed '$d' |
          cut -f17- -d' ' |
          sort |
          uniq |
          while read path; do
            path="/$path"
            if [ -L "$path" ]; then
              : # The path is a symbolic link, so is probably handled by NixOS already
            elif [ -d "$path" ]; then
              : # The path is a directory, ignore
            else
              echo "$path"
            fi
          done
        '';
      };
    };
  };
}
