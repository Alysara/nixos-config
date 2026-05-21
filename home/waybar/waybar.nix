{ pkgs, lib, ... }:

{
  catppuccin.waybar = {
    enable = true;
    mode = "createLink";
  };

  # wayland.windowManager.hyprland.settings.exec-once = [
  #  "waybar"
  # ];

  programs.waybar= {
    enable = true;
    style = ./style.css;

    settings = {
      main = {
        position = "top";
        height = 26;
        margin-top = 8;
        margin-bottom = 0;
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
          "custom/swaync"
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
          interface = "wlp0s20f3";
          format-wifi = "";
          format-ethernet = "";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{essid} ({signalStrength}%) ";
          interval = 1;
        };

        "network#network-extra" = {
          interface = "wlp0s20f3";
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

        "custom/swaync" = {
          tooltip = true;
          tooltip-format = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
          format = "{icon} ";
          format-icons = {
              notification = "<span foreground='@lavender'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='@lavender'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='@lavender'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='@lavender'><sup></sup></span>";
              dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        # "custom/hardware" = {

        # }

        # battery = {
        #   states = {
        #     95
        #   }
        # }




      };
    };
    
  };

}
