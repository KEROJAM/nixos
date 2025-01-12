{ config, lib, pkgs, ... }:

{
programs = {
kitty = {
	enable = true;
	extraConfig = '' ${builtins.readFile ../.config/kitty/kitty.conf}'';
 };
starship = {
      enable = true;
};
zoxide = {
      enable = true;
    };
tmux = {
      enable = true;
    };
fish = {
      enable = true;
      interactiveShellInit = ''${builtins.readFile ../.config/fish/config.fish}'';
    };
  };
}
