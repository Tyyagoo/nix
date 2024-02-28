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
    wipeOnBoot = mkBoolOpt false "Enable to restore specific subvolumes to an empty state on boot.";
    keepFor = mkOpt int 30 "Keep btrfs_tmp files for n days.";
  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "btrfs" ];
    environment.systemPackages = with pkgs; [ nixty.btrfsutils ];

    boot.initrd.postDeviceCommands = mkIf cfg.wipeOnBoot (lib.mkAfter ''
      mkdir /mnt
      mount /dev/mapper/cryptmain /mnt
      if [[ -e /mnt/root ]]; then
        mkdir -p /mnt/old_roots
        timestamp=$(date --date="@$(stat -c %Y /mnt/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /mnt/root "/mnt/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          delete_subvolume_recursively "/mnt/$i"
        done
        btrfs subvolume delete "$1"
      }

      for i in $(find /mnt/old_roots/ -maxdepth 1 -mtime +${builtins.toString cfg.keepFor}); do
        delete_subvolume_recursively "$i"
      done

      btrfs subvolume snapshot /mnt/root-blank /mnt/root
      umount /mnt
    '');
  };
}
