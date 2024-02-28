set -e

nix build '.#nixosConfigurations.virt.config.system.build.diskoImagesScript'

./result \
  --pre-format-files /home/tyyago/nix/secret.key secret.key \
  --pre-format-files /home/tyyago/nix/autogen.key autogen.key \
  --post-format-files /home/tyyago/nix/autogen.key /persist/secret.key
