{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware/master";

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
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:aylur/ags/v2";

    rust-overlay.url = "github:oxalica/rust-overlay";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

      overlays = with inputs; [ rust-overlay.overlays.default ];

      systems.modules.nixos = with inputs; [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
      ];

      templates = import ./templates { };
    };
}
