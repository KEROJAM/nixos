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
    adb.enable = true;
    java = {
      enable = true;
    };
    nix-ld = {
      enable = true;
    };
    river = {
      enable = false;
    };
    hyprland = {
     enable = true;
    };
    niri = {
      enable = true;
    };
    dconf.enable = true;
    steam = {
      enable = false;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
 };
}
