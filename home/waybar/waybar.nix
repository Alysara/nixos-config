{ pkgs, lib, ... }:

{
  catppuccin.waybar = {
    enable = true;
    mode = "createLink";
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
  ];

  programs.waybar= {
    enable = true;
    style = ./style.css;

    settings = {
      main = {
        position = "top";
        height = 26;
        margin-top = 8;
        margin-bottom = 6;
        margin-left = 13;
        margin-right = 13;

        modules-left = [
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces#roman"
        ];

        modules-right = [
          "network#network-extra"
          "tray"
          "pulseaudio"
          "network#network-main"
          "battery"
          "clock"
        ];

        "hyprland/window" = {
          rewrite = {
            "(.*) — Mozilla Firefox" = "$1";
            "(.*) — Zen Browser" = "$1";
            "(.*) - Visual Studio Code" = "$1";
            "• Discord \\| ([^|]*) \\| ([^|]*)" = "$2 | $1"; # Hmm this isn't working properly
          };
        };

        clock = {
          format = "{:%b %d %I:%M %p} ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          interval = 1;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% 󱐋{icon}";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "network#network-main" = {
          format-wifi = "";
          format-ethernet = "";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{essid} ({signalStrength}%) ";
          interval = 1;
        };

        "network#network-extra" = {
          format = "{bandwidthDownBits}";
          interval = 1;
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = "󰂲 {icon}";
          format-muted = "󰝟";
          format-icons = {
            hands-free = "";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [
                ""
            ];
          };
          on-click = "pavucontrol";
        };

        # battery = {
        #   states = {
        #     95
        #   }
        # }




      };
    };
    
  };

}
