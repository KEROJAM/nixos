{ config, lib, pkgs, pkgs-stable,inputs, ... }:


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

 # IDE
  jetbrains.idea-community-bin
  mongodb-compass
  mongosh
  zed-editor

 # Git
  git
  lazygit

 # Terminal
  fzf
  wezterm

 # Notifications
  libnotify
  mako
  dunst

 # Web browser
  floorp
  librewolf
  chromium

# Wallpapers/windowmanagers
  swww
  hyprlock 
  hyprsunset
  hyprpicker
  wlinhibit
  betterlockscreen
  waybar
  feh
  dwmblocks
  slstatus
  xorg.libxcb
  (pkgs.callPackage ./sddm-astronaut-theme.nix {
      theme = "pixel_sakura";
      themeConfig = {
        General = {
      #  HeaderText = "Yuri In Here";
      #  Background="";
        FontSize ="10";
        };
      };
  })
  playerctl

# Audio
  audacity
  #ardour
  reaper
  ncmpcpp
  alsa-utils

# Video Playback
  mpv
  vlc
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
  imagemagick
  tesseract

# Education
  jq
  anki
  gnome-calculator
  foliate
  hugo

# Launcher
  rofi-wayland
  rofimoji

# Office
  onlyoffice-bin

# Comunication
  signal-desktop-bin
  qbittorrent
  nheko
  vesktop
  parsec-bin

# File Managers
  nemo-with-extensions
  yazi

# Games
  protonup-qt
  steam-run
  prismlauncher
  osu-lazer-bin
  (lutris.override {
    extraPkgs = pkgs: [
      wineWowPackages.stable
    ];
  })

# Misc
  networkmanagerapplet
  wineWowPackages.stable
  findutils
  android-tools
  heimdall
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
  xcb-util-cursor
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
  bibata-cursors
  acpi
  pamixer
  xwayland-satellite

# Virtualisation
  virt-manager
  virtiofsd

# Languages
  luajit
  ispell
  python3
  texliveMedium

# Important
  keepassxc
  polkit_gnome

# NUR
  nur.repos.ataraxiasjel.waydroid-script

 ];

  # Fonts
fonts = {
  packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.mononoki
    nerd-fonts.jetbrains-mono
    google-fonts
    material-symbols
    monocraft
  ];
  fontDir.enable = true;
  fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      serif = ["Noto serif CJK CS"];
      };
    };
  };

}
