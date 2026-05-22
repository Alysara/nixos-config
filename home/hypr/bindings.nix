{ pkgs, lib, ... }:

let
    inherit ( import ./lua_utils.nix { inherit lib; })
        luaify lambda call bind_flags bind bind_exec smw with_flags on_startup;

    takeScreenshot = pkgs.writeShellScript "takeScreenshot" ''
      folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
      fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
      fullPath="$folderName/$fileName"

      mkdir -p "$folderName"
      ${pkgs.grim}/bin/grim -t ppm - | ${pkgs.satty}/bin/satty --filename - --output-filename "$fullPath"
    '';
in {
    wayland.windowManager.hyprland.settings = {
        bind = map call (builtins.concatLists [[
          /* Software */
          (bind_exec "SUPER + Z" "zen-beta")
          (bind_exec "SUPER + T" "kitty")
          (bind_exec "SUPER + C" "code")
          (bind_exec "SUPER + SHIFT + S" " ${takeScreenshot}") /* Screenshot */
          (bind_exec "Print" " ${takeScreenshot}") /* Screenshot */
          (bind_exec "SUPER + SUPER_L" "rofi -show drun -pid /tmp/wofi-pid || pkill rofi")
          (bind_exec "SUPER + V" "rofi -modi clipboard:${pkgs.cliphist}/bin/cliphist-rofi-img  -show clipboard -show-icons")

          /* Window Control */
          (bind "SUPER + Q" "hl.dsp.window.close()") /*Close Window*/
          (bind "SUPER + SHIFT + F" "hl.dsp.window.fullscreen({ mode = 'maximized', action = 'toggle'})") /* Pseudo Fullscreen */
          (bind "SUPER + F" "hl.dsp.window.fullscreen()") /* Fullscreen */
          (bind "SUPER + SHIFT + SPACE" "hl.dsp.window.float()") /* Toggle Floating */
          (bind "SUPER + O" "hl.dsp.window.set_prop({ prop = 'opaque', value = 'toggle'})") /* Toggle Opacity */

          (bind "SUPER + SHIFT + D" ''hl.dsp.window.move({ workspace = "e+1" })'')
          (bind "SUPER + SHIFT + A" ''hl.dsp.window.move({ workspace = "e-1" })'')
          (bind "SUPER + SHIFT + right" ''hl.dsp.window.move({ workspace = "e+1" })'')
          (bind "SUPER + SHIFT + left" ''hl.dsp.window.move({ workspace = "e-1" })'')
          (bind "SUPER + SHIFT + mouse_up" ''hl.dsp.window.move({ workspace = "e+1" })'')
          (bind "SUPER + SHIFT + mouse_down" ''hl.dsp.window.move({ workspace = "e-1" })'')
          (bind "SUPER + SHIFT + mouse_right" ''hl.dsp.window.move({ workspace = "e+1" })'')
          (bind "SUPER + SHIFT + mouse_left" ''hl.dsp.window.move({ workspace = "e-1" })'')

          (bind "SUPER + D" ''hl.dsp.focus({ workspace = "e+1" })'')
          (bind "SUPER + A" ''hl.dsp.focus({ workspace = "e-1" })'')
          (bind "SUPER + right" ''hl.dsp.focus({ workspace = "e+1" })'')
          (bind "SUPER + left" ''hl.dsp.focus({ workspace = "e-1" })'')
          (bind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e+1" })'')
          (bind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e-1" })'')
          (bind "SUPER + mouse_right" ''hl.dsp.focus({ workspace = "e+1" })'')
          (bind "SUPER + mouse_left" ''hl.dsp.focus({ workspace = "e-1" })'')

          /* Background */
          # (bind_exec "SUPER + R" "bash ~/.config/hypr/scripts/RandBackground.sh")
          # (bind_exec "SUPER + R" "bash ~/.config/hypr/scripts/RandBackground.sh")
      ]   


      (with_flags { mouse = true; } [
          (bind "SUPER + mouse:272" "hl.dsp.window.drag()")
          (bind "SUPER + mouse:273" "hl.dsp.window.resize()")
      ])

      (with_flags { locked = true; } [
          (bind_exec "XF86AudioNext"  "playerctl next")
          (bind_exec "XF86AudioPause" "playerctl play-pause")
          (bind_exec "XF86AudioPlay"  "playerctl play-pause")
          (bind_exec "XF86AudioPrev"  "playerctl previous")
          (bind_exec "Menu + right"  "playerctl next")
          (bind_exec "Menu + left"  "playerctl previous")
          (bind_exec "Menu + SPACE" "playerctl play-pause")
      ])

      (with_flags { repeating = true; locked = true; } [
          (bind_exec "XF86AudioRaiseVolume"  "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
          (bind_exec "XF86AudioLowerVolume"  "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
          (bind_exec "XF86AudioMute"         "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
          (bind_exec "XF86AudioMicMute"      "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
          (bind_exec "XF86MonBrightnessUp"   "bash ~/.dotfiles/scripts/step-brightness.sh up")
          (bind_exec "XF86MonBrightnessDown" "bash ~/.dotfiles/scripts/step-brightness.sh down")
      ])

      # workspaces
      # binds $mainMod + [shift +] {1..9} to [move to] workspace {1..9}
      ((builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            (bind "SUPER + ${toString ws}" ''hl.dsp.focus({ workspace = "${toString ws}" })'')
            (bind "SUPER + SHIFT + ${toString ws}" ''hl.dsp.window.move({ workspace = "${toString ws}" })'')
          ]
        ) 9)
      ))
    ]);
  };
}