inputs:
let
  module = import ./module.nix inputs;
in {
  mkSystem = import ./make-system.nix inputs;
  mkHome = import ./make-home.nix inputs;
} // module
