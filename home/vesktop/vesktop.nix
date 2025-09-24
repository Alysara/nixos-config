{ pkgs, ... }:

{
  xdg.configFile."vesktop/settings/quickCss.css".source = ./quick.css;
  programs.vesktop = {
    enable = true;
    vencord.settings.plugins = {
      "BetterFolders".enable = true;
    };
  };
}