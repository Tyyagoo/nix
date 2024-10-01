{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nixty;
let
  cfg = config.user;
  defaultIconFileName = "profile.jpg";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';
    passthru = {
      fileName = defaultIconFileName;
    };
  };

  propagatedIcon =
    pkgs.runCommandNoCC "propagated-icon"
      {
        passthru = {
          inherit (cfg.icon) fileName;
        };
      }
      ''
        local target="$out/share/icons/user/${cfg.name}"
        mkdir -p "$target"
        cp ${cfg.icon} "$target/${cfg.icon.fileName}"
      '';
in
{
  options.user = with types; {
    name = mkOpt str "tyyago" "The name to use for the user account.";
    displayName = mkOpt str "Tyyago" "The name for display.";
    email = mkOpt str "tyyago.dev@gmail.com" "The email of the user.";
    initialPassword = mkOpt str "pwd" "The initial password to use when the user is first created.";
    icon = mkOpt (nullOr package) defaultIcon "The profile picture to use for the user.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to <option>users.users.<name></option>.";
  };

  config = {
    environment.systemPackages = with pkgs; [ propagatedIcon ];
    environment.sessionVariables.FLAKE = "/home/${cfg.name}/nix";

    home.file = {
      "Documents/.keep".text = "";
      "Downloads/.keep".text = "";
      "Music/.keep".text = "";
      "Pictures/.keep".text = "";
      "dev/.keep".text = "";
      ".face".source = cfg.icon;
      "Pictures/${cfg.icon.fileName or (builtins.baseNameOf cfg.icon)}".source = cfg.icon;
    };

    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialPassword;
      home = "/home/${cfg.name}";
      group = "users";

      extraGroups = [
        "wheel"
        "audio"
        "sound"
        "video"
        "networkmanager"
        "input"
        "tty"
        "docker"
      ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
