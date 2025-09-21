{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ./hypr/hyprland.nix
    ./waybar/waybar.nix
    ./rofi/rofi.nix
    ./kitty/kitty.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alysara";
  home.homeDirectory = "/home/alysara";

  programs.git = {
    enable = true;
    userName = "Alysara";
    userEmail = "alysara@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    wl-clipboard
    yazi


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    (pkgs.writeShellScriptBin "fastcommit" (builtins.readFile ../scripts/fastcommit.sh))
    (pkgs.writeShellScriptBin "buildnix" (builtins.readFile ../scripts/buildnix.sh))
    (pkgs.writeShellScriptBin "buildhome" (builtins.readFile ../scripts/buildhome.sh))
  ];

  programs.vesktop.enable = true;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alysara/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  #programs.bash.enable = true; 
  #programs.bash.shellAliases = {
  #  ll = "ls -l";
  #  ".." = "cd ..";
  #  buildhome = "home-manager switch --flake ~/.dotfiles";
  #  buildnix = "sudo nixos-rebuild switch --flake ~/.dotfiles";
  #};

  programs.bash = {
    enable = true; 
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };
  };

  programs.home-manager.enable = true;
  programs.vscode.enable = true;
}
