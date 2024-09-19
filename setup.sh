set -e

read -sp "passphrase: " pass
echo
read -sp "confirm": confirm
echo

if [ "$pass" = "$confirm" ]; then
  echo -n $pass > /tmp/secret.key
else
  echo "passphrases do not match"
  exit 0
fi

dd bs=512 count=4 if=/dev/random of=/tmp/autogen.key iflag=fullblock
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./systems/x86_64-linux/mu/disko.nix --arg ssd '"/dev/nvme0n1"' --arg hdd '"/dev/sda"'
btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
nixos-generate-config --no-filesystems --root /mnt
cp -f /mnt/etc/nixos/hardware-configuration.nix ./systems/x86_64-linux/mu/hardware.nix
git add .
cp -r ../nix /mnt/home/tyyago/
dd bs=512 count=4 if=/tmp/autogen.key of=/mnt/persist/secret.key
chown root:root /mnt/persist/secret.key; chmod 400 /mnt/persist/secret.key
nixos-install --root /mnt --flake .#mu
