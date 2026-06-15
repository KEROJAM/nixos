{
  inputs,
  config,
  pkgs,
  ...
}:
{
  services = {
    # Flatpak/dbus
    flatpak = {
      enable = true;
    };
    dbus.enable = true;
    udisks2.enable = true;
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    emacs.enable = true;
    #sunshine = {
     # enable = true;
     # autoStart = true;
     # openFirewall = true;
     # package = pkgs.sunshine.override {
     #    cudaSupport = true;
     #    cudaPackages = pkgs.cudaPackages;
     # };
    #};
    blueman.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
      };
    };
    supergfxd = {
      enable = true;
    };
    syncthing = {
      enable = true;
      user = "kerojam";
      group = "users";
      dataDir = "/home/kerojam/";
      configDir = "/home/kerojam/.config/syncthing";
      extraFlags = [
        "--no-browser"
      ];
    };
    pulseaudio.enable = false;
  };
}
