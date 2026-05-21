{ inputs, pkgs, config, fetchurl, lib, ... }:


let
#  stepBrightness = pkgs.writeShellScriptBin "step-brightness" ''
#    #!/usr/bin/env bash
#
#    steps=(0 1 2 3 5 10 15 25 40 60 80 100)
#
#    current=$(brightnessctl -d intel_backlight g)
#    max=$(brightnessctl -d intel_backlight m)
#    cur_percent=$((100 * current / max))
#
#    if [[ $1 == "up" ]]; then
#        for s in "''${steps[@]}"; do
#            if (( s > cur_percent )); then
#                brightnessctl -d intel_backlight s "''${s}%"
#                exit 0
#            fi
#        done
#    elif [[ $1 == "down" ]]; then
#        prev=0
#        for s in "''${steps[@]}"; do
#            if (( s >= cur_percent )); then
#                brightnessctl -d intel_backlight s "''${prev}%"
#                exit 0
#            fi
#            prev=$s
#        done
#    fi
#  '';

  inherit(import ./lua_utils.nix { inherit lib; }) luaify lambda call bind_flags bind bind_exec smw with_flags on_startup;
in {
  home.packages = [
    pkgs.brightnessctl
    # stepBrightness
  ];

  imports = [
    # ./hypredge.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
   
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    
    settings = {
      monitor = [ ",preferred,auto,1.25" ];

      workspace = [
        "1, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "special:mini, gapsout:128"
      ];

      windowrule = [
        # "workspace 1 silent, class:^vesktop$"
      ];
    
      xwayland.force_zero_scaling = true;

      on = on_startup ''
	hl.exec_cmd("waybar")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("vesktop")
      '';
      
      #  exec_cmd = [
      #   "[workspace 1] vesktop"
      #   "[workspace 2] zen"
      #   "nm-applet"
      #   "proton-vpn"
      #   "wl-paste --watch cliphist store"
      # ];

      general = {
        border_size = 1;
        # no_border_on_floating = false;
        gaps_in = 5;
        gaps_out = 10;
        float_gaps = 0;
        gaps_workspaces = 0;
        "col.inactive_border" = "0xff444444"; 
        "col.active_border" = "0xffffffff";
        "col.nogroup_border" = "0xffffaaff";
        "col.nogroup_border_active" = "0xffff00ff";
        layout = "dwindle";
        no_focus_fallback = false;
        resize_on_border = false;
        extend_border_grab_area = 15;
        hover_icon_on_border = false;
        allow_tearing = false;
        resize_corner = 0;

        snap = {
          enabled = true;
          window_gap = 10;
          monitor_gap = 10;
          border_overlap = false;
          respect_gaps = false;
        };
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1;
        dim_modal = true;
        dim_inactive = true;
        dim_strength = 0.2;
        dim_special = 0.2;
        dim_around = 0.4;
        # screen_shader = [insert path here]
        border_part_of_window = true;
        blur = {
          enabled = true;
          size = 8;
          ignore_opacity = true;
          new_optimizations = true;
          xray = false;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0;
          special = false;
          popups = false;
          popups_ignorealpha = 0.2;
          input_methods = false;
          input_methods_ignorealpha = 0.2;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          sharp = false;
          # ignore_window = true;
          color = "0xee1a1a1a";
          # color_inactive = unset # type color
          # offset = "[0, 0]"; needs a vec2:stof, figure out how to make ?
          scale = 1;
        };
      };

      input = {
        kb_layout = "us";
        sensitivity = 0;
      };

      #bindm = [
      #  "SUPER, mouse:272, movewindow"
#	      "SUPER, mouse:273, resizewindow"
     # ];

     bind = map call (builtins.concatLists [[
     	(bind_exec "SUPER + Z" "zen-beta")
	(bind_exec "SUPER + T" "kitty")
	(bind_exec "SUPER + F" "hl.dsp.window.fullscreen()")
	(bind_exec "SUPER + SHIFT + A" (smw "move_to_workspace -1"))
	(bind_exec "SUPER + SHIFT + D" (smw "move_to_workspace +1"))
	(bind_exec "SUPER + A" (smw "cycle_workspaces -1"))
	(bind_exec "SUPER + D" (smw "cycle_workspaces +1"))
      ]]);

      #binde = [
      #  "SUPER SHIFT, left, resizeactive, 10 0"
      #  "SUPER SHIFT, right, resizeactive, -10 0"
      #  "SUPER SHIFT, up, resizeactive, 0 -10"
      #  "SUPER SHIFT, down, resizeactive, 0 10"
      #];

      #bindel = [
      #  ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      #  ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      #  ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      #  ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      #  ",XF86MonBrightnessUp, exec, step-brightness up"
      #  ",XF86MonBrightnessDown, exec, step-brightness down"
      #];

      #bindl = [
      #  ",XF86AudioNext, exec, playerctl next"
      #  ",XF86AudioPause, exec, playerctl play-pause"
      #  ",XF86AudioPlay, exec, playerctl play-pause"
      #  ",XF86AudioPrev, exec, playerctl previous"
      #];

      #bind = [
      #  "SUPER, E, exec, kitty"
      #  "SUPER Shift, F, exec, firefox"
      #  "SUPER, Z, exec, zen-beta"
      #  "SUPER, C, exec, code"
      #  "SUPER, R, exec, kitty fish -C y"
      #  "SUPER, B, exec, kitty btop"
      #  "SUPER, T, exec, ${pkgs.hdrop}/bin/hdrop -f -p t -g 0 -h 40 -w 67 kitty --class kitty_hdrop"

      #  "SUPER, Q, killactive,"
      #  "SUPER, M, exit,"
      #  "SUPER, F, fullscreen,"
      #  "SUPER, Escape, togglefloating,"
      #  "SUPER, V, exec, rofi -modi clipboard:${pkgs.cliphist}/bin/cliphist-rofi-img  -show clipboard -show-icons"
      #  "SUPER, P, pseudo,"
      #  # "SUPER, J, layoutmsg, togglesplit,"

      #  "SUPER, left, movefocus, l"
      #  "SUPER, right, movefocus, r"
      #  "SUPER, up, movefocus, u"
      #  "SUPER, down, movefocus, d"
#
#        "SUPER, A, workspace, e-1"
#        "SUPER, D, workspace, e+1"
#
#        "SUPER Shift, A, movetoworkspace, e-1"
#        "SUPER Shift, D, movetoworkspace, e+1"
#
#        "SUPER, W, togglespecialworkspace, mini"
#        "SUPER, S, movetoworkspacesilent, special:mini"
#        "SUPER, S, movetoworkspacesilent, +0"
#      ]
#      ++ (
#        builtins.concatLists (builtins.genList (i:
#            let ws = i + 1;
#            in [
#              "SUPER, ${toString ws}, workspace, ${toString ws}"
#              "SUPER SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
#            ]
#          )
#          9)
#      );

    };
  };
}
