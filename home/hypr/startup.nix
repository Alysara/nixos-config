{ inputs, pkgs, config, fetchurl, lib, ... }:

let
  inherit(import ./lua_utils.nix { inherit lib; }) luaify lambda call bind_flags bind bind_exec smw with_flags on_startup;
in {
  wayland.windowManager.hyprland.settings = {
      on = on_startup ''
        hl.exec_cmd("waybar")
        hl.exec_cmd("nm-applet")
        hl.exec_cmd("vesktop")
        hl.exec_cmd("vesktop")
        hl.exec_cmd("wl-paste --match cliphist store")
        hl.exec_cmd("hyprpaper")
      '';
  };
}