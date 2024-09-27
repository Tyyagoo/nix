{ self, nixpkgs, namespace, ... }@inputs:
host: system:
let
  config-folder = "${self}/nixos/configurations/${host}";
  config = "${config-folder}/configuration.nix";
  hardware = "${config-folder}/hardware.nix";
in nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit self inputs namespace host system; };
  modules = self.nixosModules ++ [
    config
    hardware
    {
      networking.hostName = host;
      system.configurationRevision = toString
        (self.shortRev or self.dirtyShortRev or self.lastModified or "unknown");
      environment.systemPackages = with nixpkgs.legacyPackages.${system};
        [ git ];
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
    }
  ];
}
