{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # setttings = {
    #   confirm_os_window_close = false;
    #   enable_audio_bell = false;
    # };
    # extraConfig = ''
    #  map ctrl+a select_all
    # '';
  };

  catppuccin.kitty.enable = true;
}
