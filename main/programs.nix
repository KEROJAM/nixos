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
    java.enable = true;
  };
}
