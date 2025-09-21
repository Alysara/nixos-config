{ config, ... }:

{
  programs.rofi.enable = true;


  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "stayfocused, class:^Rofi$"
      "norounding, class:^Rofi$"
    ];

    bindr = [
      "$mainMod, Super_L, exec, rofi -show drun -pid /tmp/wofi-pid || pkill rofi"
    ];
  };
}
