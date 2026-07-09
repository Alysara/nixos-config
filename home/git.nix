{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = [
      "*.private.nix"
			".envrc"
			".direnv/"
    ];
  };
}
