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
      useRoutingFeatures = "server";
    };
    emacs = { 
      enable = true;
      defaultEditor = true;
      package = pkgs.emacs-pgtk;
    };
    #sunshine = {
     # enable = true;
     # autoStart = true;
     # openFirewall = true;
     # package = pkgs.sunshine.override {
     #    cudaSupport = true;
     #    cudaPackages = pkgs.cudaPackages;
     # };
    #};
    dnscrypt-proxy = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;
        query_log.file = "/var/log/dnscrypt-proxy/query.log";
        sources.public-resolvers = {
          urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"  
          ];
          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"; 
        };
        server_names = [ "quad9-dnscrypt-ip4-filter-ecs-pri" "mullvad-all-doh"  ];
      };
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
