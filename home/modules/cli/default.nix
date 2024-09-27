{ pkgs, ... }: {
  imports =
    [ ./bash ./bat ./direnv ./fzf ./git ./gpg ./nushell ./pfetch ./ssh ];

  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them

    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator
    trekscii # Cute startrek cli printer
    timer

    nixd # Nix LSP
    nixfmt-rfc-style # Nix formatter
    nvd # Differ
    nix-diff # Differ, more detailed
    nix-output-monitor
    nh # Nice wrapper for NixOS and HM

    ltex-ls # Spell checking LSP
  ];
}
