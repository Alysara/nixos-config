{ lib, ... }:
let
  wallpaper = toString ../../images/ruin-campfire.png;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprpaper"
    ];
  };
  
  services.hyprpaper = {
    enable = true;
    settings = {
      # Using the new wallpaper block format
      wallpaper = [
        {
          monitor = "";  # Empty monitor acts as fallback for all monitors
          path = wallpaper;
          fit_mode = "cover";  # Optional: cover, contain, or tile
        }
      ];
    };
  };
}