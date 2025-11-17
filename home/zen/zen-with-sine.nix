# zen-with-sine.nix
{ pkgs, inputs, ... }:

let
  sineDeps = import ./sine.nix { inherit pkgs; };
  fxAutoconfig = sineDeps.fxAutoconfig;
  sine = sineDeps.sine;
  zenSrc = inputs.zen-browser.packages.${pkgs.system}.default;
in
pkgs.stdenv.mkDerivation {
  pname = "zen-with-sine";
  version = "1.0";

  buildPhase = ''
    mkdir -p $out
    cp -r ${zenSrc}/* $out/

    # Copy fx-autoconfig files
    cp ${fxAutoconfig}/config.js $out/config.js
    mkdir -p $out/defaults/pref
    cp ${fxAutoconfig}/defaults/pref/config-prefs.js $out/defaults/pref/config-prefs.js

    # Copy Sine engine
    mkdir -p $out/profile/chrome/JS
    cp -r ${sine}/JS/* $out/profile/chrome/JS/
  '';
}
