{ pkgs, ... }: {
  home.packages = with pkgs; [
    github-cli
    git-lfs
    obs-studio
    chromium
    firefox
    kdenlive
    shotcut
    clang
    clang-tools
    vlc
    file
    nix-index
  ];
}
