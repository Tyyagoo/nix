# echo -n "pwd" > /tmp/secret.key
dd bs=512 count=4 if=/dev/random of=/tmp/autogen.key iflag=fullblock
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./systems/x86_64-linux/virt/disko.nix --arg ssd '"/dev/sda"' --arg hdd '"/dev/sdb"'
nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ./systems/x86_64-linux/virt/hardware.nix
git add .
cp -r ../nix /mnt/home/tyyago/
dd bs=512 count=4 if=/tmp/autogen.key of=/mnt/persist/secret.key
chown root:root /mnt/persist/secret.key; chmod 400 /mnt/persist/secret.key
nixos-install --root /mnt --flake .#virt
