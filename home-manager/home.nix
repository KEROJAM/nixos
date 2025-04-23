{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nvim.nix
    ./terminal.nix
    inputs.ags.homeManagerModules.default
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kerojam";
  home.homeDirectory = "/home/kerojam";


  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
   # inputs.astal.packages.${system}.default
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
    ags = {
      enable = true;
      extraPackages = with pkgs; [
        inputs.astal.packages.${system}.network
        inputs.astal.packages.${system}.tray
        inputs.astal.packages.${system}.apps
        inputs.astal.packages.${system}.battery
        astal.river
        astal.hyprland
        astal.astal4
        astal.io
        astal.notifd
        astal.battery
        astal.mpris
        astal.wireplumber
        astal.powerprofiles
        astal.network
        astal.bluetooth
        fzf
      ];
    };
  };
  
  wayland.windowManager.river = {
    extraConfig = ''
    ${builtins.readFile ../.config/river/init}
    ${builtins.readFile ../.config/river/disable-gpu.sh}
    '';
  };
  xdg.configFile."river/init" = {
    enable = true;
    source = "${../.config/river/init}";
    executable = true;
    };
  xdg.configFile."river/disable-gpu" = {
    enable = true;
    source = "${../.config/river/disable-gpu.sh}";
    executable = true;
    };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
