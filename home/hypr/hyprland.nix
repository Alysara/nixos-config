{
  inputs,
  pkgs,
  config,
  fetchurl,
  lib,
  ...
}:

let
  inherit (import ./lua_utils.nix { inherit lib; })
    luaify
    lambda
    call
    bind_flags
    bind
    bind_exec
    smw
    with_flags
    on_startup
    ;
in
{
  home.packages = [
    pkgs.brightnessctl
    # stepBrightness
  ];

  imports = [
    # ./hypredge.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./bindings.nix
    ./startup.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    configType = "lua";
    settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto-left";
          scale = 1.25;
        }
      ];

      on = [
        (call [
          "window.fullscreen"
          (luaify ''
            function(window)
            				if window.fullscreen > 0 then
            					hl.exec_cmd("pkill -USR1 waybar")
            				else
            					hl.exec_cmd("pkill -USR2 waybar") end
            			end'')
        ])
        (call [
          "window.active"
          (luaify ''
            function(window)
            				if window and window.fullscreen > 0 then
            					hl.exec_cmd("pkill -USR1 waybar")
            				else
            					hl.exec_cmd("pkill -USR2 waybar") end
            			end'')
        ])
      ];

      # workspace = [
      #  "1, persistent:true"
      #  "2, persistent:true"
      #  "3, persistent:true"
      #  "special:mini, gapsout:128"
      # ];

      #windowrule = [
      # "workspace 1 silent, class:^vesktop$"
      #];

      #  exec_cmd = [
      #   "[workspace 1] vesktop"
      #   "[workspace 2] zen"
      #   "nm-applet"
      #   "proton-vpn"
      #   "wl-paste --watch cliphist store"
      # ];

      config = {
        xwayland.force_zero_scaling = true;

        general = {
          border_size = 1;
          # no_border_on_floating = false;
          gaps_in = 0;
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
          rounding = 0;
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

        curve = [
          (call [
            "easeOutQuint"
            {
              type = "bezier";
              points = [
                [
                  0.23
                  1
                ]
                [
                  0.32
                  1
                ]
              ];
            }
          ])
          (call [
            "easeInOutCubic"
            {
              type = "bezier";
              points = [
                [
                  0.65
                  0.05
                ]
                [
                  0.36
                  1
                ]
              ];
            }
          ])
          (call [
            "linear"
            {
              type = "bezier";
              points = [
                [
                  0
                  0
                ]
                [
                  1
                  1
                ]
              ];
            }
          ])
          (call [
            "almostLinear"
            {
              type = "bezier";
              points = [
                [
                  0.5
                  0.5
                ]
                [
                  0.75
                  1
                ]
              ];
            }
          ])
          (call [
            "quick"
            {
              type = "bezier";
              points = [
                [
                  0.15
                  0
                ]
                [
                  0.1
                  1
                ]
              ];
            }
          ])
          (call [
            "easy"
            {
              type = "spring";
              mass = 1;
              stiffness = 71.2633;
              dampening = 15.8273644;
            }
          ])
        ];

        animation = [
          {
            leaf = "global";
            enabled = true;
            speed = 10;
            bezier = "default";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 5.39;
            bezier = "easeOutQuint";
          }
          {
            leaf = "windows";
            enabled = true;
            speed = 4.79;
            spring = "easy";
          }
          {
            leaf = "windowsIn";
            enabled = true;
            speed = 4.1;
            spring = "easy";
            style = "popin 87%";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 1.49;
            bezier = "linear";
            style = "popin 87%";
          }
          {
            leaf = "fadeIn";
            enabled = true;
            speed = 1.73;
            bezier = "almostLinear";
          }
          {
            leaf = "fadeOut";
            enabled = true;
            speed = 1.46;
            bezier = "almostLinear";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 3.03;
            bezier = "quick";
          }
          {
            leaf = "layers";
            enabled = true;
            speed = 3.81;
            bezier = "easeOutQuint";
          }
          {
            leaf = "layersIn";
            enabled = true;
            speed = 4;
            bezier = "easeOutQuint";
            style = "fade";
          }
          {
            leaf = "layersOut";
            enabled = true;
            speed = 1.5;
            bezier = "linear";
            style = "fade";
          }
          {
            leaf = "fadeLayersIn";
            enabled = true;
            speed = 1.79;
            bezier = "almostLinear";
          }
          {
            leaf = "fadeLayersOut";
            enabled = true;
            speed = 1.39;
            bezier = "almostLinear";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 3;
            bezier = "easeInOutCubic";
            style = "slide";
          }
          {
            leaf = "workspacesIn";
            enabled = true;
            speed = 3;
            bezier = "easeInOutCubic";
            style = "slide";
          }
          {
            leaf = "workspacesOut";
            enabled = true;
            speed = 3;
            bezier = "easeInOutCubic";
            style = "slide";
          }
          {
            leaf = "zoomFactor";
            enabled = true;
            speed = 7;
            bezier = "quick";
          }
        ];
      };
    };
  };
}
