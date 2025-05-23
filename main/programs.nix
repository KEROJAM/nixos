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
    direnv = {
      enable = true;
      loadInNixShell = true;
    };
    adb.enable = true;
    java = {
      enable = true;
    };
    nix-ld = {
      enable = true;
    };
    river = {
      enable = true;
    };
    hyprland = {
     enable = true;
    };
    niri = {
      enable = false;
    };
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
 };
}
