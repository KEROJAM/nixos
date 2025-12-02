{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs = {
    fish = {
      enable = true;
    };
    tmux = {
      enable = true;
      plugins = [ pkgs.tmuxPlugins.rose-pine ];
    };
    adb.enable = true;
    java = {
      enable = true;
    };
    nix-ld = {
      enable = true;
    };
    river-classic = {
      enable = false;
      xwayland.enable = true;
    };
    dwl = {
      enable = false;
      package = pkgs.dwl.overrideAttrs {
        src = /home/kerojam/dwl;
      };
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}
