{ inputs, pkgs, fetchurl, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    
    package = inputs.hyperland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyperland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings.monitor = [ ",preferred,auto,1.25" ];

  };
}
