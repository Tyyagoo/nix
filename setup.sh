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
echo "[DONE] Disko"
btrfs subvolume snapshot -r /mnt /mnt/root-blank
# btrfs subvolume snapshot -r /mnt/home /mnt/home-blank
echo "[DONE] Empty snapshots"
nixos-generate-config --no-filesystems --root /mnt
echo "[DONE] NixOS generate config"
cp -f /mnt/etc/nixos/hardware-configuration.nix ./systems/x86_64-linux/mu/hardware.nix
git add .
mkdir /mnt/home/tyyago
cp -r ../nix /mnt/home/tyyago/nix
dd bs=512 count=4 if=/tmp/autogen.key of=/mnt/home/tyyago/.keyfile
chown root:root /mnt/home/tyyago/.keyfile; chmod 400 /mnt/home/tyyago/.keyfile
echo "[START] NixOS install"
nixos-install --root /mnt --flake .#mu
