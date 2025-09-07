{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs = {
    zsh = {
      enable = false;
      autosuggestions.enable = true;
      enableCompletion = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        	${builtins.readFile ../.config/fish/config.fish}
      '';
    };
    tmux = {
      enable = true;
      plugins = [ pkgs.tmuxPlugins.rose-pine ];
    };
    adb.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk24;
    };
    nix-ld = {
      enable = true;
    };
    river-classic = {
      enable = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    niri = {
      enable = true;
    };
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}
