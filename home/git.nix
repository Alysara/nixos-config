{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = [
      "*.private.nix"
      "flake.nix"
      "flake.lock"
      "!.dotfiles/"
    ];
  };
}