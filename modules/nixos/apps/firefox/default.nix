{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.apps.firefox;
  name = config.user.name;
  inherit (lib) mkIf;
in
{
  options.${namespace}.apps.firefox = {
    enable = mkEnableOpt;
  };

  config = mkIf cfg.enable {
    home.programs.firefox = {
      enable = true;
      profiles.${name} = {
        inherit (name)
          ;
        id = 0;

        settings = {
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.aboutwelcome.enabled" = false;
        };
        extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          facebook-container
          betterttv
        ];
      };
    };
  };
}
