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
    hyprland = {
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
    java.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      env = {
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
      args = [
         "--hdr-enabled"
         "--expose-wayland"
      ];
    };
  };
}
