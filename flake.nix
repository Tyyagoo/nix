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

    nixpkgs-f2k = {
      url = "github:fortuneteller2k/nixpkgs-f2k";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cowsay.url = "github:snowfallorg/cowsay?ref=v1.3.0";
  };
  outputs = inputs: let
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
  in 
    lib.mkFlake {
      channels-config.allowUnfree = true;
      overlays = with inputs; [
        nixpkgs-f2k.overlays.window-managers
      ];
      systems.modules.nixos = with inputs; [];
      templates = import ./templates {};
    };
}
