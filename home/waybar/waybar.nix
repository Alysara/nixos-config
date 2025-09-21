{ pkgs, lib, ... }:

{

  catpuccin.waybar = {
    enable = true;
    mode = "createLink";
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
  ];

  programs.waybar= {
    enable = true;

    settings = {
      main = {
        position = "top";
        height = 26;
        margin-top = -8;
        margin-bottom = 6;
        margin-left = 13;
        margin-right = 13;

        modules-left = [
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "battery"
          "clock"
        ];

        
      }
    }
    
  };

}
