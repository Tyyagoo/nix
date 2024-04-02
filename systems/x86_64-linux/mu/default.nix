{ lib, pkgs, inputs, format, virtual, config, system, ... }:
with lib;
with lib.nixty;
let
  baremetal = !virtual && format != "iso";
  hardware = with inputs.hardware.nixosModules; [
    common-cpu-amd
    # common-gpu-amd
  ];
in {
  imports = hardware ++ [
    ./hardware.nix
    inputs.disko.nixosModules.disko
    (import ./disko.nix {
      ssd = "/dev/nvme0n1";
      hdd = "/dev/sda";
    })
  ];

  disko.enableConfig = baremetal;
  # hardware.amdgpu.amdvlk = true;

  apps = {
    alacritty = enabled;
    bitwarden = enabled;
    discord = enabled;
    ncmpcpp = enabled;
    steam = enabled;
  };

  desktop.hyprland = enabled;
  # desktop.gnome = enabled;

  security = { gpg = enabled; };

  services = { mpd' = enabled; };

  suites = { study = enabled; };

  system = {
    boot.efi = enabled;
    audio = enabled;
    fonts = enabled;
    locale = enabled;
    network = enabled;
    nix = enabled;
    time = enabled;
    shell.default = "nushell";
    storage.btrfs = mkIf baremetal {
      enable = true;
      wipeOnBoot = false;
    };
  };

  tools = {
    direnv = enabled;
    git = enabled;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [ 
    appimage-run
    exercism
    firefox
    godot_4
    gdtoolkit
    openssl
    pkg-config
    gcc
    cmake
    meson
    ninja
    rust-bin.stable.latest.default
  ];

  boot.loader.grub.enableCryptodisk = true;
  environment.etc."crypttab".text = ''
    cryptsec /dev/disk/by-partlabel/disk-secondary-luks /persist/secret.key
  '';

  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     cores = 4;
  #     memorySize = 4096;
  #     qemu.options = [ "-vga std" "-accel kvm" ];
  #   };
  # };

  system.stateVersion = "23.11";
}
