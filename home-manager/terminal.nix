{ config, lib, pkgs, ... }:

{
programs = {
kitty = {
	enable = true;
	extraConfig = builtins.readFile ../.config/kitty;
 };
starship = {
      enable = true;
      settings = builtins.readFile ../.config/starship.toml;
    };
    zoxide = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
  };
}
