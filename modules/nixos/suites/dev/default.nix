{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.suites.dev;
in {
  options.suites.dev = with types; { enable = mkBoolOpt' false; };

  config = mkIf cfg.enable {
    security = { gpg = enabled; };

    tools = {
      direnv = enabled;
      git = enabled;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    environment.systemPackages = with pkgs; [
      vscodium
      exercism
      godot_4
      gdtoolkit_4
      openssl
      pkg-config
      gcc
      cmake
      meson
      ninja
      rust-bin.stable.latest.default
    ];
  };
}
