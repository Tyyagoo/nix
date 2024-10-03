{
  description = "Here's my effort to keep myself on nixos while having a comfy and crazy workstation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    cutefetch.url = "github:alphatechnolog/cutefetch";
    webx.url = "github:face-hh/webx";
    nexusfetch.url = "gitlab:alxhr0/nexusfetch";
    aether-shell.url = "github:alphatechnolog/aether-shell";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    ags.url = "github:Aylur/ags";

    decay-nvim-src = {
      url = "github:decaycs/decay.nvim";
      flake = false;
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-cursor-src = {
      url = "github:ful1e5/apple_cursor";
      flake = false;
    };

    decay-discord-src = {
      url = "github:decaycs/decay-discord";
      flake = false;
    };

    picom-sdhand-src = {
      url = "github:sdhand/picom";
      flake = false;
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      config = import ./config.nix;
      inherit (config) system;
    in
    with config;
    rec {
      devShells.${system}.default =
        let
          nixSystem = nixosConfigurations.${hostname};
          vm = nixSystem.config.system.build.vm;
          pkgs = import nixpkgs { inherit system; };
          lib = pkgs.lib;
        in
        pkgs.mkShell {
          name = "dev-shell";
          buildInputs = [ vm ];
          shellHook = ''
            echo "Type ${lib.getExe vm} to run the system vm"
          '';
        };

      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem rec {
        inherit system;

        specialArgs = {
          inherit inputs system;
          flakeConfig = config;
        };

        modules =
          [
            mainModule
            inputs.disko.nixosModules.disko
          ]
          ++ nixpkgs.lib.optionals (!config.modules.homeManager.enable) [
            inputs.home-manager.nixosModules.home-manager
            (mainModule + /home-manager.nix)
          ];
      };
    };
}
