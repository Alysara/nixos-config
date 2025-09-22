{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    setttings = {
      confirm_os_window_close = false;
      enable_audio_bell = false;
    };
    # extraConfig = ''
    #  map ctrl+backspace send_text all \x17
    # '';
  };

  catppuccin.kitty.enable = true;
}
