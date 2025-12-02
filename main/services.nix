{
  inputs,
  config,
  pkgs,
  ...
}:
{
  services = {
    picom = {
      enable = true;
    };
    # Flatpak/dbus
    flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      packages = [
        "com.obsproject.Studio"
        "com.github.tchx84.Flatseal"
        "org.vinegarhq.Sober"
      ];
      update.onActivation = true;
      uninstallUnmanaged = true;
    };
    dbus.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
    };
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
    mysql = {
      enable = true;
      package = pkgs.mysql84;
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
    system76-scheduler = {
      enable = true;
      settings.cfsProfiles.enable = true;
    };
  };
}
