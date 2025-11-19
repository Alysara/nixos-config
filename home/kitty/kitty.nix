{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      # enable_audio_bell = 0;
    };
    # extraConfig = ''
    #  map ctrl+a select_all
    # '';
  };

  catppuccin.kitty.enable = true;
}
