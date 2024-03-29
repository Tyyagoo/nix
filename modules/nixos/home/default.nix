{ options, config, lib, inputs, ... }:
with lib;
with lib.nixty; {
  options.home = with types; {
    file = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>home.file</option>.";

    configFile = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>home.configFile</option>.";

    programs = mkOpt attrs { } "Programs to be managed by home-manager.";
    services = mkOpt attrs { } "Services to be managed by home-manager.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
      programs = mkAliasDefinitions options.home.programs;
      services = mkAliasDefinitions options.home.services;
    };

    home-manager = {
      useUserPackages = true;
      users.${config.user.name} = mkAliasDefinitions options.home.extraOptions;
    };
  };
}
