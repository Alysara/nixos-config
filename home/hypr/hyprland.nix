{ inputs, pkgs, fetchurl, lib, ... }:

{
  services.displayManager = {
    sessionPackages = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    ];
  }; 
  wayland.windowManager.hyprland = {
    enable = true;
   
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    
    settings.monitor = [ ",preferred,auto,1.25" ];

  };
}
