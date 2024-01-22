#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
 
  networking = { 

  hostName = "YuriPC"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  firewall.enable = true;


  # Enable networking
  networkmanager.enable = true;
   };

services.resolved = {
	enable = true;
	dnssec = "true";
	domains = [ "~." ];
	fallbackDns = [ "9.9.9.9#dns.quad9.net" "149.112.112.112#dns.quad9.net" ];
	extraConfig = ''
		DNSOverTLS=yes
		'';
};

  # Set your time zone.
  time.timeZone = "America/Monterrey";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
    ];
}; 
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kerojam = {
    isNormalUser = true;
    description = "KEROJAM";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };
  
  # NIXOS
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
	nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

            nixpkgs.config.permittedInsecurePackages = [
                "python-2.7.18.6"
              ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

 # Text Editors
   emacs
   neovim

 # Git
   git

 # Terminal
   kitty

 # Notifications
   libnotify
   mako
   dunst

 # Web browser
   firefox
   brave
   librewolf

# Wallpapers/windowmanagers
  swww
  feh
  dwmblocks
  (pkgs.dwmblocks.overrideAttrs (old: {
	src = /home/kerojam/dwmblocks;
  }))
  waybar
  xorg.libxcb

# Audio
  audacity
  deadbeef
  lmms

# Video Playback
  mpv
  vlc
  ffmpeg_6-full 
  obs-studio
  (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  })
  #davinci-resolve

# Image Editing
  krita
  grim
  slurp
  maim
  slop 
  flameshot

# Education
  jq
  anki

# Launcher
  rofi-wayland

# Comunication
  vesktop
  signal-desktop

# File Managers
  cinnamon.nemo-with-extensions   

# Games
  protonup-qt 
  steam
  weston
  waydroid
  prismlauncher
  heroic
  godot_4
  osu-lazer-bin

# Misc
  pavucontrol
  neofetch
  cbonsai
  wget
  ripgrep
  fd
  wl-clipboard
  xclip
  xdotool
  lsd
  bat
  tldr
  gparted
  btop
  dbus
  udiskie
  xdg-utils
  lzip
  unzip
  xorg.xf86inputlibinput
  libinput
  lxappearance
  home-manager
  papirus-icon-theme
  acpi

# Virtualisation
  virt-manager
  virtiofsd
  qemu
  qemu_kvm

# Languages 
  libclang
  lua-language-server
  ispell

# Important
  keepassxc
  syncthing
  polkit_gnome

# NUR
  nur.repos.ataraxiasjel.waydroid-script

 ];


# Fonts
fonts = {
packages = with pkgs; [
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
];
fontDir.enable = true;
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  

 # Hardware

 services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };
  };

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  
  # Virtualisation

  virtualisation.waydroid.enable = true;
	programs.dconf.enable = true;
	virtualisation.libvirtd ={
		enable = true;
		qemu = {
			package = pkgs.qemu_kvm;
			ovmf.enable = true;
			ovmf.packages = [ pkgs.OVMFFull.fd ];
			swtpm.enable = true;
			runAsRoot = false;
		};
	};

	environment.etc = {
		"ovmf/edk2-x86_64-secure-code.fd" = {
    			source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
  		};

  		"ovmf/edk2-i386-vars.fd" = {
    			source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
  			};

		};


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  
  # Flatpak/dbus
  	services.flatpak.enable = true;
  	services.dbus.enable = true;
        xdg.portal = {
	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
};

  # Polkit

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

		extraConfig = ''
		 DefaultTimeoutStopSec=10s
		'';
	};

  # Window Managers
	services.picom = {
		enable = true;
  		fade = true;
	};
  services.xserver.windowManager.dwm = {
		enable = true;
	        package = pkgs.dwm.overrideAttrs {
 			 src = /home/kerojam/dwm;
			};
		};

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

	nixpkgs.overlays = [
 		(self: super: {
   	 	mpv = super.mpv.override {
      		scripts = [ self.mpvScripts.mpvacious ];
    			};
		})
	];



  services.redshift = {
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
  location.provider = "geoclue2";
# OpenGl

  hardware.opengl = {
	  enable = true;
	  driSupport = true;
	  driSupport32Bit = true;
  };

# Sound

	sound.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
	};

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
 
  # Kernels
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  # Games
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	};

  nix.optimise.automatic = true;
  nix.gc = {
  	automatic = true;
  	dates = "weekly";
 	options = "--delete-older-than 30d";
	};
  boot.tmp.cleanOnBoot = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
