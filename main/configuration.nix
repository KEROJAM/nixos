#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
#  patchedQemu = pkgs.qemu_full.overrideAttrs (old: {
#    patches = (old.patches or [ ]) ++ [ ./qemu-10.2.2.patch ];
#  });
in
{
  imports = [
    # Include the results of the hardware scan.
    ./packages.nix
    ./services.nix
    ./programs.nix
    ./input.nix
    ./systemd.nix
  ];
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [ 47984 47989 47990 48010 ];
      allowedUDPPortRanges = [
         { from = 47998; to = 48000; }
         { from = 8000; to = 8010; }
      ];
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
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "ydotool"
    ];
    packages = with pkgs; [ ];
  };
  # Shell

  users.defaultUserShell = pkgs.fish;
  # NIXOS
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
  # Virtualisation

  virtualisation = {
    waydroid.enable = false;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu;
        swtpm.enable = true;
        runAsRoot = false;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.groups.libvirtd.members = ["KEROJAM"];
  users.groups.kvm.members = ["KEROJAM"];

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
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      gsettings-desktop-schemas
    ];
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
  };
  # Services and Window Managers
  services = {
    displayManager = {
      ly.enable = true;
    };
  };
  # Nix Overlays
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.XDG_DATA_DIRS = lib.mkForce "/usr/local/share:/usr/share:/var/lib/snapd/desktop";
  nixpkgs.overlays = with builtins; [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.mpvacious ];
      };
    })
  ];

  location.provider = "geoclue2";

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
