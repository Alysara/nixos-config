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
        "explorer.confirmDragAndDrop" = false;
        "files.autoSave" = "afterDelay";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "explorer.confirmDelete" = false;
        "editor.fontFamily" = "'Hack Nerd Font', 'Droid Sans Mono', 'monospace'";
        "editor.fontLigatures" = true;
        "terminal.integrated.fontLigatures.enabled" = true;
      };
    };

  };
}