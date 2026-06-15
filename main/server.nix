{
inputs,
system,
pkgs,
...
}:
{

virtualisation = {
	docker = {
	enable = true;	
	};
};

services = {
  jellyfin = {
   enable = true;
   dataDir = "/home/kerojam/Media/";
   cacheDir = "/home/kerojam/.cache/jellyfin";
   user = "kerojam";
   openFirewall = true;
  };
  deluge = {
   enable = true;
   declarative = true;
   openFirewall = true;
   web.enable = true;
   web.openFirewall = true;
   dataDir = "/home/kerojam/Media";
   authFile = "/home/kerojam/.config/deluge/auth";
   user = "kerojam";
   group = "jellyfin";
  };
  tailscale = {
   enable = true;
   openFirewall = true;
   useRoutingFeatures = "server";
   extraSetFlags = ["--advertise-exit-node"];
  };

  glance = {
   enable = true;
   openFirewall = true;
   settings.server.host = "0.0.0.0";
  };
  openssh.enable = true;
 # xserver = {
 #  enable = true;
 #     xkb = {
 #   layout = "us";
 #   variant = "";
 #  };
 # };
  #displayManager.gdm = {
  # enable = true;
  # autoSuspend = false;
  #};
  #desktopManager.gnome.enable = true;

  pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = true;
   jack.enable = true;
  };
 };
nixpkgs.config.allowUnfree = true;
environment.systemPackages = with pkgs; [
 git
 vim
 wget
];

fonts = {
 packages = with pkgs; [
	 noto-fonts
	 noto-fonts-cjk-sans
  ];
 fontconfig = {
  enable = true;
  defaultFonts = {
  serif = [ "Noto serif CJK CS"];
   };
  };
};

users.users.kerojam = {
 isNormalUser = true;
 description = "kerojam";
 extraGroups = [ "networkmanager" "wheel" "media" "docker"];
};
nix.settings.experimental-features = ["nix-command" "flakes"];
users.groups.media = { };
system.stateVersion = "25.05";
}
