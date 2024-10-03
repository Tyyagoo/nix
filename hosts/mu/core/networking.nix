{ flakeConfig, ... }:

{
  time = { inherit (flakeConfig) timeZone; };

  networking = {
    hostName = flakeConfig.hostname;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        # 22
        # 4444
        # 8000
        # 3000 
      ];
    };

    networkmanager.enable = true;
  };
}
