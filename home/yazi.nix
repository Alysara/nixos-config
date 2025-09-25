{pkgs, ... }: 



{
  home.packages = with pkgs; [
    xdg-desktop-portal-termfilechooser
  ];

  programs.yazi.enable = true;
  catppuccin.yazi.enable = true;

  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      default_dir=$HOME
      open_mode=last
      save_mode=last
    '';
    recursive = true;
  };
}