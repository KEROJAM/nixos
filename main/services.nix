{ inputs, config, pkgs, ... }:

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
      "com.xnview.XnViewMP"
      "com.obsproject.Studio"
      "com.github.tchx84.Flatseal"
      "com.ktechpit.torrhunt"
      "org.gaphor.Gaphor"
      "com.heroicgameslauncher.hgl"
      "com.beavernotes.beavernotes"
      "org.vinegarhq.Sober"
    ];
    update.onActivation = true;
    uninstallUnmanaged = true;
    };
  dbus.enable = true;
  udisks2.enable = true;
  libinput = {
    enable = true;
    mouse = {
        accelProfile = "flat";
	middleEmulation = false;
    };
    touchpad = {
	naturalScrolling = true;
	disableWhileTyping = true;
    };
   };
  # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      ports = [22];
      settings = {
	PasswordAuthentication = false;
      };
    };
    mongodb = {
      enable = true;
      package = pkgs.mongodb-ce;
    };
    redshift = {
      enable = true;
      brightness = {
        day = "1";
        night = "1";
      };
      temperature = {
        day = 8500;
        night = 3700;
      };
    };
    geoclue2.enable = true;
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
    emacs = {
      enable = true;
    };
    pulseaudio.enable = false;
  #system76-scheduler = {
  #    enable = false;
  #    settings.cfsProfiles.enable = true;
  #  };
  };
}
