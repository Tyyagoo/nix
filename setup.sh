nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./systems/x86_64-linux/virt/disko.nix --arg ssd '"/dev/sda"' --arg hdd '"/dev/sdb"'
