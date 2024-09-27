{ pkgs, ... }: {
  imports = [ ./fonts ./gtk ./qt ];

  home.packages = with pkgs; [ xdragon ];
}
