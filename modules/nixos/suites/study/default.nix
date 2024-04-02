{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.suites.study;
in {
  options.suites.study = with types; { enable = mkBoolOpt' false; };

  config = mkIf cfg.enable {
    # TODO: wtf i'm doing with my life?
    home.extraOptions.xdg.desktopEntries = {
      obsidian = {
        name = "obsidian";
        comment = "Knowledge base (AppImage)";
        icon = "obsidian";
        exec = "appimage-run /home/tyyago/appimg/Obsidian.AppImage";
        categories = [ "Office" ];
        mimeType = [ "x-scheme-handler/obsidian" ];
        prefersNonDefaultGPU = false;
      };
    };

    environment.systemPackages = with pkgs; [ zotero ];
  };
}
