{ pkgs, ... }:

{
  xdg.configFile."vesktop/settings/quickCss.css".source = ./quick.css;
  programs.vesktop = {
    enable = true;
    plugins = [
      "BetterFolders".enable = true;
    ]
  }
}