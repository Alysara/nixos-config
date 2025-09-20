{ inputs, pkgs, fetchurl, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
   
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    
    settings.monitor = [ ",preferred,auto,1.25" ];

  };
}
