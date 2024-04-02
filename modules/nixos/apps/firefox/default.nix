{ options, config, lib, pkgs, inputs, system, ... }:
with lib;
with lib.nixty;
let 
  cfg = config.apps.firefox;
  name = config.user.name;
in {
  options.apps.firefox = with types; { enable = mkBoolOpt false "Enable firefox"; };

  config = mkIf cfg.enable {
    home.programs.firefox = {
      enable = true;
      profiles.${name} = {
        inherit (name);
        id = 0;
        settings = {
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.aboutwelcome.enabled" = false;
        };
        extensions = with inputs.firefox-addons.packages.${system}; [
          ublock-origin
          sponsorblock
          facebook-container
          # betterttv ### TODO: allowUnfree isn't working
        ];
      };
    };
  };
}
