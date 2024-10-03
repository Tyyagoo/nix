{ pkgs, ... }:
{
  services.picom = {
    enable = true;
    package = pkgs.picom-git;
    extraArgs = [ "--experimental-backends" ];

    settings = {
      backend = "glx";
      corner-radius = 10;
      round-borders = 10;
      fading = true;
      fade-in-step = 9.9e-2;
      fade-out-step = 9.9e-2;

      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];

      round-borders-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];
    };
  };
}
