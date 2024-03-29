{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:Tyyagoo/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    ags.url = "github:Aylur/ags";

    matugen.url = "github:InioX/matugen";

    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          namespace = "nixty";
          meta = {
            name = "nixty";
            title = "NixTy";
          };
        };
      };
    in lib.mkFlake {
      channels-config.allowUnfree = true;
      overlays = with inputs; [
        rust-overlay.overlays.default
      ];
      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
      ];
      templates = import ./templates { };
    };
}
