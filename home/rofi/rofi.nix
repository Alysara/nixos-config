{ config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in {

  xdg.configFile."rofi/colors.rasi".source = ./colors.rasi;
	xdg.configFile."rofi/style.rasi".source = ./style.rasi;


  programs.rofi = {
    enable = true;
    extraConfig = {
      dpi = 144;
      show-icons = true;
      cycle = false;
      scroll-method = 1;
      drun-display-format = "{name}";
    };

  #   theme = {
  #     "*" = {
  #       background = mkLiteral "@mantle";
  #       lightfg = mkLiteral "@lavender";
  #       placeholder = mkLiteral "@overlay0";
  #     };

  #     window = {
  #       width = mkLiteral "20em";
  #       border-radius = mkLiteral "20";
  #     };

  #     entry.placeholder-color = mkLiteral "@placeholder";

  #     num-rows.text-color = mkLiteral "@placeholder";
  #     num-filtered-rows.text-color = mkLiteral "@placeholder";
  #     textbox-num-set.text-color = mkLiteral "@placeholder";
  #   };

    theme = "~/.config/rofi/colors.rasi";
  };

  # catppuccin.rofi.enable = true;


  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "stayfocused, class:^Rofi$"
      "norounding, class:^Rofi$"
    ];

    bindr = [
      "$mainMod, Super_L, exec, rofi -show drun -pid /tmp/wofi-pid || pkill rofi"
    ];
  };

  programs.yazi.settings = {
    opener = {
      rofi-open = [
        { run = "rofi -show drun -run-command '{cmd} \"'\"$@\"'\"'"; desc = "Open With"; }
      ];
    };
    open = {
      append_rules = [
        { name = "*"; use = "rofi-open"; }
        { name = "*/"; use = "rofi-open"; }
      ];
    };
  };

}
