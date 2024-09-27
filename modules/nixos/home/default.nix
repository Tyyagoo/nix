{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace}; {
  options.home = with types; {
    file = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>home.file</option>.";

    configFile = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>home.configFile</option>.";

    packages = mkOpt attrs { } "Packages to be managed by home-manager.";
    programs = mkOpt attrs { } "Programs to be managed by home-manager.";
    services = mkOpt attrs { } "Services to be managed by home-manager.";
    sessionVariables =
      mkOpt attrs { } "Environment variables to always set at login.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    home.extraOptions = {
      xdg = {
        enable = true;
        configFile = mkAliasDefinitions options.home.configFile;
      };

      programs = mkAliasDefinitions options.home.programs;
      services = mkAliasDefinitions options.home.services;

      home = {
        stateVersion = config.system.stateVersion;
        file = mkAliasDefinitions options.home.file;
        packages = mkAliasDefinitions options.home.packages;
        sessionVariables = mkAliasDefinitions options.home.sessionVariables;
      };
    };

    home-manager = {
      useUserPackages = true;
      users.${config.user.name} = mkAliasDefinitions options.home.extraOptions;
    };
  };
}
