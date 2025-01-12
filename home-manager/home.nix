{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nvim.nix
    ./terminal.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kerojam";
  home.homeDirectory = "/home/kerojam";


  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];

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

  home.sessionVariables = {
     EDITOR = "neovim";
  };
  programs = {
   git = {
      enable = true;
      userName = "KEROJAM";
      userEmail = "majorekcs@hotmail.com";
    };
  };
  wayland.windowManagers.river = {
    extraConfig = ''${builtins.readFile ../.config/river/init}'';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
