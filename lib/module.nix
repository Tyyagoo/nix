{ nixpkgs, ... }:
with nixpkgs.lib;
rec {
  ## Create a NixOS module option.
  ##
  ## ```nix
  ## lib.mkOpt nixpkgs.lib.types.str "My default" "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  ## Create a NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkOpt' nixpkgs.lib.types.str "My default"
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt' = type: default: mkOpt type default null;

  
  ## Create a boolean NixOS module option.
  ##
  ## ```nix
  ## lib.mkBoolOpt true "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt = mkOpt types.bool;

  ## Create a boolean NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkBoolOpt' true
  ## ```
  ##
  #@ Bool
  mkBoolOpt' = mkOpt' types.bool;

  ## Create a string NixOS module option.
  ##
  ## ```nix
  ## lib.mkStrOpt "default" "description"
  ## ```
  ##
  #@ String -> String
  mkStrOpt = mkOpt types.str;

  ## Create a string NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkStrOpt' "default"
  ## ```
  ##
  #@ String
  mkStrOpt' = default: mkStrOpt default "";
}
