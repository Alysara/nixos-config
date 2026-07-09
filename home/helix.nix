{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    escapeTime = 0;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_theme storm
          set -g @tokyo-night-tmux_transparent 0
        '';
      }
    ];
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ',*:Tc'
      set -as terminal-overrides ',*:sitm=\E[3m'

      set -g status-position top
      
      # Use Vim keybindings in copy mode
      set -g mode-keys vi

      # Optional: enable mouse scrolling
      set -g mouse on

      # Optional: copy to system clipboard
      set -g set-clipboard on
      '';
  };

  programs.helix = {
    enable = true;
		package = pkgs.evil-helix;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        scrolloff = 8;
        auto-save = {
          after-delay = {
            enable = true;
            timeout = 1000;
          };

          focus-lost = true;
        };
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
        };
        indent-guides.render = true;
        lsp.display-inlay-hints = false;
        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "error";
        };
        # sticky-context.enable = true;
      };
      keys = {
        insert = {
          j = { k = "normal_mode"; };
          "C-h" = "delete_char_forward";
        };
        normal = {
          space = {
            i = {
              h = ":toggle lsp.display-inlay-hints";
              c = ":toggle inline-diagnostics.cursor-line warning disable";
              o = ":toggle inline-diagnostics.other-lines error disable";
              e = ":toggle end-of-line-diagnostics warning disable";
            };
            m = ":format";
          };
          "{" = "goto_prev_paragraph";
          "}" = "goto_next_paragraph";
        };
        select = {
          "{" = "goto_prev_paragraph";
          "}" = "goto_next_paragraph";
        };
      };
    };
    themes = {
      tokyonight = {
        "inherits" = "tokyonight";
        "ui.background" = {};
      };
    };
  };
}
