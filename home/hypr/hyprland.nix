{ inputs, pkgs, fetchurl, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
   
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    
    settings = {
      monitor = [ ",preferred,auto,1.25" ];

      workspace = [
        "1, persistent:true"
      ];
    
      xwayland.force_zero_scaling = true;

      "$mainMod" = "SUPER";

      bindm = [
        "$mainMod, mouse:272, movewindow"
	      "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        "$mainMod SHIFT, left, resizeactive, 10 0"
        "$mainMod SHIFT, right, resizeactive, -10 0"
        "$mainMod SHIFT, up, resizeactive, 0 -10"
        "$mainMod SHIFT, down, resizeactive, 0 10"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -d intel_backlight s 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight s 5%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      bind = [
        "$mainMod, E, exec, kitty"
        "$mainMod, F, exec, firefox"
        "$mainMod, R, exec, kitty fish -C y"
        "$mainMod, Escape, exec, ${pkgs.hdrop}/bin/hdrop -f -p t -g 0 -h 40 -w 67 kitty --class kitty_hdrop"

        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, C, fullscreen,"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, A, workspace, e-1"
        "$mainMod, D, workspace, e+1"

        "$mainMod Shift, A, movetoworkspace, e-1"
        "$mainMod Shift, D, movetoworkspace, e+1"

        "$mainMod, W, togglespecialworkspace, mini"
        "$mainMod, S, movetoworkspacesilent, special:mini"
        "$mainMod, S, movetoworkspacesilent, +0"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mainMod, ${toString ws}, workspace, ${toString ws}"
              "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );

    };
  };
}
