{ lib, ... }:
with lib;
rec {
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  mkOpt' = type: default: mkOpt type default null;

  mkBoolOpt = mkOpt types.bool;

  mkBoolOpt' = mkOpt' types.bool;

  mkEnableOpt = mkBoolOpt' false;

  mkDisableOpt = mkBoolOpt' true;

  mkStrOpt = default: description: mkOpt types.str default description;

  mkStrOpt' = default: mkStrOpt default null;
}
