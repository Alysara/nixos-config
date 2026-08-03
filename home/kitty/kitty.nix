{ pkgs, ... }:
let
  kittyScrollback = pkgs.vimPlugins.kitty-scrollback-nvim;
in
{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      font_family = "FiraCode Nerd Font";
      font_size = 11;
      background_opacity = 0.5;
      background_blue = 1;

      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";
      scrollback_lines = 10000;

			tab_bar_edge = "top";  # or "bottom" (default)
			tab_bar_style = "powerline";  # options: fade, separator, powerline, slant, custom, hidden
			tab_powerline_style = "slanted";  # slanted, angled, round

			active_tab_foreground = "#1e1e2e";
			active_tab_background = "#89b4fa";
			inactive_tab_foreground = "#cdd6f4";
			inactive_tab_background = "#313244";

			tab_bar_background = "#11111b";
			active_tab_font_style = "bold";
			inactive_tab_font_style = "normal";
			tab_bar_margin_width = 0;
			tab_bar_margin_height = "0 0";

			# tab_bar_min_tabs = 2;
			#
			# tab_title_template = "{index}: {title}";
    };
    extraConfig = ''
      action_alias kitty_scrollback_nvim kitten ${kittyScrollback}/python/kitty_scrollback_nvim.py
      map kitty_mod+i kitty_scrollback_nvim
      map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output

			# Window navigation, vim-style
			map kitty_mod+h previous_tab
			map kitty_mod+l next_tab 

			# Half-page scroll, vim-style
			map kitty_mod+d scroll_page_down
			map kitty_mod+u scroll_page_up
    '';
  };

	catppuccin.kitty.enable = true;
}
