{ pkgs, ... }:

{
  programs.vesktop.enable = true;
  xdg.configFile."vesktop/settings/quickCss.css".source = ./quick.css;
}