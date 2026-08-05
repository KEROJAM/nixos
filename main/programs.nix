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
    localsend = {
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
    steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    ydotool.enable = true;
    java.enable = true;
  };
}
