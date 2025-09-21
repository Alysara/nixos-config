{ inputs, pkgs, fetchurl, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    nvidiaPatches = true;
   
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    hardware = {
      opengl.enable = true;
      nvidia.modesetting.enable = true;
    };

    settings = {
      monitor = [ ",preferred,auto,1.25" ];

      workspace = [
        "1, persistent:true"
      ];
    
      xwayland.force_zero_scaling = true;
    };
  };
}
