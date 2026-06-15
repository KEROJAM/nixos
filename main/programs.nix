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
    nix-ld = {
      enable = true;
    };
    mango = {
      enable = true;
    };
    dconf.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override { extraPkgs = pkgs: [
         pkgs.fuse 
      ];};
    };
    ydotool.enable = true;
    java.enable = false;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };
  };
}
