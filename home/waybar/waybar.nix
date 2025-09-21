{ pkgs, lib, ... }:

{
  programs.waybar.enable = true;

  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
  ];
}
