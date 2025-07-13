{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  nixpkgs.config = {

    allowUnfree = true;

    permittedInsecurePackages = [
      "olm-3.2.16"
    ];
  };
  environment.systemPackages = with pkgs; [
    # Text Editors
    emacs
    vim
    obsidian

    # IDE
    zed-editor

    # Terminal
    fzf
    wezterm

    # Notifications
    libnotify
    mako
    dunst

    # Web browser
    floorp
    firefox
    librewolf
    chromium

    # Wallpapers/windowmanagers
    swww
    inputs.quickshell.packages.x86_64-linux.default
    hyprlock
    hyprsunset
    hyprpicker
    hyprcursor
    wlinhibit
    betterlockscreen
    waybar
    feh
    slstatus
    xorg.libxcb
    (pkgs.callPackage ./sddm-astronaut-theme.nix {
      theme = "pixel_sakura";
      themeConfig = {
        General = {
          #  HeaderText = "Yuri In Here";
          #  Background="";
          FontSize = "10";
        };
      };
    })
    playerctl
    xwayland-satellite

    # Audio
    #ardour
    reaper
    ncmpcpp
    alsa-utils

    # Video Playback
    mpv
    ffmpeg_6-full
    aegisub
    #davinci-resolve

    # Image Editing
    krita
    grim
    slurp
    #maim
    slop
    flameshot
    tesseract
    xnviewmp

    # Education
    jq
    anki-bin
    gnome-calculator
    foliate
    hugo

    # Launcher
    rofi-wayland

    # Office
    onlyoffice-bin

    # Comunication
    signal-desktop-bin
    qbittorrent
    vesktop
    parsec-bin

    # File Managers
    nemo-with-extensions
    yazi

    # Games
    protonup-qt
    steam-run
    prismlauncher
    melonDS
    osu-lazer-bin

    # Misc
    gnome-decoder
    networkmanagerapplet
    wineWowPackages.stable
    findutils
    libsForQt5.qt5.qtgraphicaleffects
    trash-cli
    udiskie
    wireplumber
    pavucontrol
    brightnessctl
    fastfetch
    cbonsai
    wget
    ripgrep
    fd
    wl-clipboard
    wf-recorder
    gtk3
    xclip
    xdotool
    xorg.xcbutilwm
    lsd
    bat
    tldr
    gparted
    btop
    xdg-utils
    lzip
    unzip
    xorg.xf86inputlibinput
    lxappearance
    darkman
    papirus-icon-theme
    rose-pine-gtk-theme
    acpi
    pamixer

    # Virtualisation
    virt-manager
    virtiofsd

    # Languages
    ispell
    python3

    # Important
    keepassxc
    polkit_gnome

    # NUR
    #nur.repos.ataraxiasjel.waydroid-script

  ];

  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.mononoki
      #google-fonts
      material-symbols
      monocraft
    ];
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "Noto serif CJK CS" ];
      };
    };
  };

}
