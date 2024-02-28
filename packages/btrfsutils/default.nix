{ writeShellApplication, pkgs, ...}:
  writeShellApplication {
    name = "btrfs-utils";
    runtimeInputs = with pkgs; [];
    # TODO: *cryptmain* from disko config
    text = ''
      cmd_diff() {
        MNTPOINT=$(mktemp -d)
        echo "$MNTPOINT"
        sudo mount -o subvol=/ /dev/mapper/cryptmain "$MNTPOINT"
        trap 'sudo umount $MNTPOINT; rm -rf $MNTPOINT' EXIT

        OLD_TRANSID=''$(sudo btrfs subvolume find-new "$MNTPOINT"/root-blank 9999999)
        OLD_TRANSID=''${OLD_TRANSID#transid marker was }

        sudo btrfs subvolume find-new "$MNTPOINT"/root "$OLD_TRANSID" |
        sed '$d' |
        cut -f17- -d' ' |
        sort |
        uniq |
        while read -r path; do
          path="/$path"
          if [ -L "$path" ]; then
            : # The path is a symbolic link, so is probably handled by NixOS already
          elif [ -d "$path" ]; then
            : # The path is a directory, ignore
          else
            echo "$path"
          fi
        done
      }

      case "$1" in
        diff|d) shift;  cmd_diff                ;;
        *)              echo "Unknown command." ;;
      esac
      exit 0
    '';
  }

