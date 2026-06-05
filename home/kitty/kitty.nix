{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
  ];
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      font_family = "FiraCode Nerd Font";
      font_size = 11;
      background_opacity = 0.2;
      background_blue = 1;
    };
  };

  catppuccin.kitty.enable = true;
}
