nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./systems/x86_64-linux/virt/disko.nix --arg ssd '"/dev/sda"' --arg hdd '"/dev/sdb"'
nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ./systems/x86_64-linux/virt/hardware.nix
git add .
cp -r ../nix /mnt/home/tyyago/
nixos-install --root /mnt --flake .#virt
