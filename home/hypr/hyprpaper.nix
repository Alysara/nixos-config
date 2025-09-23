{ lib, ... }:

let
  wallpaper = toString ../../images/ruin-campfire.png;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user start hyprpaper"
    ];
  };
  
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = wallpaper;
      wallpaper = " , ${wallpaper}";
    };
  };
}