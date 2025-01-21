{ config, lib, pkgs, ... }:

{
programs = {
kitty = {
	enable = true;
	extraConfig = '' ${builtins.readFile ../.config/kitty/kitty.conf}'';
};
zoxide = {
      enable = true;
    };
tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
	rose-pine
      ];
      extraConfig = ''
      set -g @rose_pine_variant "dawn"
    '';
    };
starship = {
      enable = true;
      settings = {
	format = lib.concatStrings [
	  "$username"
	  "$hostname"
	  "$directory"
	  "$git_branch"
	  "$git_status"
	  "$custom"
	  "$cmd_duration $jobs $time"
	  "$c"
	  "$dotnet"
	  "$kotlin"
	  "$java"
	  "$lua"
	  "$rust"
	  "$nix_shell"
	  "$line_break"
	  "$character"
	];
	character = {
	 success_symbol = "🌸";
	};
	hostname = {
	  ssh_only = false;
	};
	username = {
	  style_user = "white bold";
	  format = "[$user]($style) ";
	  disabled = false;
	  show_always = true;
	};
	git_branch = {
	  symbol = "🌱 "; 
	};
	custom = {
	  syncthing = {
	    detect_folders = [".stfolder"];
	    symbol = "🔄";
	    format = "$symbol";
	  };
	};
      };
    };
  };
}
