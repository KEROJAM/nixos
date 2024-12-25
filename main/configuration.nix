#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./packages.nix
      ./hardware/hardware-configuration-Lap.nix
    ];
  networking = {

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  #firewall.enable = true;
  #firewall.allowedTCPPorts = [ 80 443];

  # Enable networking
  networkmanager = { 
      enable = true;
      wifi.powersave = null;
    };
  };


# Set your time zone.
  time.timeZone = "America/Monterrey";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
    ];
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
    adb.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;
  console.font = ''
    export XDG_CACHE_HOME="$(mktemp -d)"
  '';
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

  services.libinput = {
    enable = true;
    mouse = {
        accelProfile = "flat";
	middleEmulation = false;
    };
    touchpad = {
	naturalScrolling = true;
  };
 };

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  services.udisks2.enable = true;
  # Virtualisation

  virtualisation.waydroid.enable = true;
	programs.dconf.enable = true;
	virtualisation.libvirtd ={
		enable = true;
		qemu = {
			package = pkgs.qemu_full;
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
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
        PasswordAuthentication = false;
      };
    };
  # Flatpak/dbus
  services.flatpak.enable = true;
  services.dbus.enable = true;
        xdg.portal = {
	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gnome];
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
  };
  services.xserver = {
  enable = true;
  xkb.layout = "us";
  displayManager.lightdm.enable = true;
  desktopManager.gnome.enable = true;
  windowManager = {
    awesome = {
      enable = true;
      luaModules = with pkgs.extraLuaPackages; [
	 connman_dbus
	 connman_widget
	 dbus_proxy
	 enum
	 media_player
	 power_widget
	 pulseaudio_dbus
	 pulseaudio_widget
	 upower_dbus
      ];
    };
    dwm = {
	enable = true;
	package = pkgs.dwm.overrideAttrs {
 	src = /home/kerojam/dwm;
	  };
	};
    };
  };  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL= "1";
	nixpkgs.overlays = with builtins; [
 		(self: super: {
   	 	mpv = super.mpv.override {
      		scripts = [ self.mpvScripts.mpvacious ];
    			};
		
		dwmblocks = super.dwmblocks.overrideAttrs (oldAttrs: {
			src = /home/kerojam/dwmblocks;
				});
		awesome = super.awesome.overrideAttrs {
		  gtk3Support = true;
		 pname = "awesome-git";
		 src = super.fetchFromGitHub {
		   owner = "awesomeWM";
		   repo = "awesome";
		   rev = "0f950cbb625175134b45ea65acdf29b2cbe8c456";
		   sha256 = "GIUkREl60vQ0cOalA37sCgn7Gv8j/9egfRk9emgGm/Y=";
		  };
		  patches = [];
		  postPatch = ''
		  patchShebangs tests/examples/_postprocess.lua 
		 '';
		};
	    })
	  (
	    import (fetchGit {
	      url = "https://github.com/stefano-m/nix-stefano-m-nix-overlays.git";
	      rev = "6d0170471fa27f31bd7a136df33a39dcd0615255";
	  })
	  )
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
 
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
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
