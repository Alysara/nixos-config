{ pkgs, ... }:

{
  fonts.fongconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
  ];
}