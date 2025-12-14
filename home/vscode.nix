{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        catppuccin.catppuccin-vsc
        ms-python.python
        arrterian.nix-env-selector
        # quarto.quarto
        ms-vscode.cpptools-extension-pack
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        # ms-vscode.cpptools-themes
        # llvm-vs-code-extensions.vscode-clangd

      ];

      userSettings = {
        "explorer.confirmDragAndDrop" = false;
        "files.autoSave" = "afterDelay";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "explorer.confirmDelete" = false;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace'";
        "editor.fontLigatures" = true;
        "terminal.integrated.fontLigatures.enabled" = true;

        "git.confirmSync" = false;
        
        # "C_Cpp.default.cppStandard" = "c++23";
        # "C_Cpp.default.intelliSenseMode" = "linux-clang-x64";
        # "C_Cpp.clang_format_fallbackStyle" = "LLVM";
        # "C_Cpp.formatting" = "clangFormat";
        # "C_Cpp.codeAnalysis.clangTidy.enabled" = true;
        # "C_Cpp.default.compilerPath" = "clang-cpp";
        # "C_Cpp.intelliSenseEngine" = "disabled";

        # "C_Cpp.default.cppStandard" = "c++23";
        # "C_Cpp.default.intelliSenseMode" = "linux-clang-x64";
        # "C_Cpp.clang_format_fallbackStyle" = "LLVM";
        # "C_Cpp.formatting" = "clangFormat";
        # "C_Cpp.codeAnalysis.clangTidy.enabled" = true;
        # "C_Cpp.default.compilerPath" = "clang++";
        # "C_Cpp.intelliSenseEngine" = "disabled";
      };
    };

  };
}