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
    direnv = {
      enable = true;
    }; 
    nix-ld.enable = true;
    mango = {
      enable = true;
    };
    localsend = {
      enable = true;
    };
    dconf.enable = true;
    appimage = {
      enable = false;
      binfmt = false;
      package = pkgs.appimage-run.override { extraPkgs = pkgs: [
         pkgs.fuse 
      ];};
    };
    gamescope.enable = true;
    steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
