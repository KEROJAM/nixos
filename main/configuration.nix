#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./packages.nix
    ];
  networking = {
    networkmanager = { 
      enable = true;
      wifi.powersave = null;
    };
    firewall = {
      enable = true;
      allowPing = false;
    };
  };

# Set your time zone.
  time.timeZone = "America/Monterrey";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
	fcitx5-mozc
	  fcitx5-gtk
	  fcitx5-rose-pine
      ];
      waylandFrontend = true;
      settings.inputMethod = {
	"keyboard-us" = {
	  "KeyDelay" = 0;
	};
	"keyboard-latam" = {
	  "KeyDelay" = 0;
	};
	"mozc" = {
	  "ActivateOnLaunch" = true;
            "CompositionMode" = "Direct";
            "PreeditMethod" = "Roman";
            "Display/AsciiMode" = "HalfWidthAlphanumeric";
            "Display/CandidateWindowStyle" = "Vertical";
	};
      };
    };
}; 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kerojam = {
    isNormalUser = true;
    description = "KEROJAM";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };
  # Shell
  programs = {
    zsh = {
      enable = true;
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
      libraries = with pkgs; [
      ];
    };
    river = {
      enable = false;
    };
    niri = {
      enable = true;
    };
    hyprland = {
      enable = true;
    };
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
 };
  users.defaultUserShell = pkgs.fish;
  # NIXOS
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
    # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  
 # Software

 

  hardware.opentabletdriver =  {
    enable = true;
    daemon.enable = true;
    };
  # Virtualisation

  virtualisation = { 
    waydroid.enable = true;
    libvirtd ={
      enable = true;
      qemu = {
	package = pkgs.qemu;
	ovmf = { 
	  enable = true;
	  packages = [ pkgs.OVMFFull.fd ];
	};
	swtpm.enable = true;
	runAsRoot = false;
      };
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
xdg.portal = {
	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gnome];  # Polkit
  };
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
  # Services and Window Managers
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
      "app.zen_browser.zen"
      "com.spotify.Client"
      "com.github.tchx84.Flatseal"
      "com.ktechpit.torrhunt"
      "org.gaphor.Gaphor"
      "com.heroicgameslauncher.hgl"
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
  xserver = {
    enable = true;
    xkb.layout = "us";
    windowManager = {
      dwm = {
	enable = true;
	package = pkgs.dwm.overrideAttrs {
	  src = inputs.dwm;
	};
      };
    };
    desktopManager.gnome.enable = false;
  };  
  displayManager = {
    #ly.enable = true;
    sddm = {
      enable = true;
      theme = "sddm-astronaut";
    };
  };
  
  pulseaudio.enable = false;
  system76-scheduler = {
      enable = true;
      settings.cfsProfiles.enable = true;
    };
  };

# Nix Overlays
  environment.sessionVariables.NIXOS_OZONE_WL= "1";
  nixpkgs.overlays = with builtins; [
 		(self: super: {
   	 	mpv = super.mpv.override {
      		scripts = [ self.mpvScripts.mpvacious ];
    			};
		
		dwmblocks = super.dwmblocks.overrideAttrs (oldAttrs: {
			src = inputs.dwmblocks;
			});
		
	    })
	];



  
  location.provider = "geoclue2";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
 
	
  nix.optimise.automatic = true;
  nix.gc = {
  	automatic = true;
  	dates = "weekly";
 	options = "--delete-older-than 30d";
	};
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
