{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        scrolloff = 8;
        auto-save = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
        };
        indent-guides.render = true;
        lsp.display-inlay-hints = false;
      };
      keys.insert = {
        j = { k = "normal_mode"; };
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
