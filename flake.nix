{
  outputs = inputs:
    let
      namespace = "nixty";
      specialArgs = inputs // { inherit namespace; };
    in {
      nixosConfigurations = import ./nixos/configurations specialArgs;
      nixosModules = import ./nixos/modules;

      homeConfigurations = import ./home/configurations specialArgs;
      homeModules = import ./home/modules;

      lib = import ./lib specialArgs;

      packages = import ./packages specialArgs;
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "nixpkgs";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    flake-checker.url = "github:DeterminateSystems/flake-checker";
    flake-checker.inputs.nixpkgs.follows = "nixpkgs";
  };
}
