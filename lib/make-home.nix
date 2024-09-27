{ self, namespace, ... }@inputs:
{ userName, displayName, email, host, system }:
let config = "${self}/home/configurations/${user}@${host}.nix";
in inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  extraSpecialArgs = {
    inherit inputs self host system namespace;
    user = { inherit userName displayName email; };
  };
  modules = [
    config
    {
      home = {
        username = userName;
        homeDirectory = "/home/${userName}";
      };

      nix = {
        package = inputs.nixpkgs.legacyPackages.${system}.nix;
        settings.experimental-features = [ "nix-command" "flakes" ];
      };

      programs.home-manager.enable = true;
    }
  ];
}
