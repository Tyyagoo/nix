{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
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
      overlays = with inputs; [];
      systems.modules.nixos = with inputs; [];
      templates = import ./templates {};
    };
}
