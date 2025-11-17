# sine.nix
{ pkgs, ... }:

let
  fxAutoconfig = pkgs.stdenv.mkDerivation rec {
    pname = "fx-autoconfig";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "MrOtherGuy";
      repo = "fx-autoconfig";
      rev = "master"; # or a commit hash
      sha256 = "0000000000000000000000000000000000000000000000000000"; # replace with actual hash
    };

    buildPhase = ''
      mkdir -p $out/defaults/pref
      mkdir -p $out/chrome

      cp ${src}/program/config.js $out/config.js
      cp ${src}/program/defaults/pref/config-prefs.js $out/defaults/pref/config-prefs.js
      cp -r ${src}/profile/chrome/* $out/chrome/
    '';
  };

  sine = pkgs.stdenv.mkDerivation rec {
    pname = "sine";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "CosmoCreeper";
      repo = "Sine";
      rev = "main"; # or a commit hash
      sha256 = "0000000000000000000000000000000000000000000000000000"; # replace with actual hash
    };

    buildPhase = ''
      mkdir -p $out/JS
      unzip ${src}/deployment/engine.zip -d $out/JS/
    '';
  };
in
{
  inherit fxAutoconfig sine;
}
