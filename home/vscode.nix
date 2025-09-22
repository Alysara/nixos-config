{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        catppuccin.catppuccin-vsc
      ];

      userSettings = {
        "files.autoSave" = "afterDelay";
        "workbench.colorTheme" = "Catppuccin Mocha";
      };
    };

  };
}