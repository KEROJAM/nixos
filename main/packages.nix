{ config, lib, pkgs, pkgs-stable,inputs, ... }:


{

  nixpkgs.config = {
    
    allowUnfree = true;

            permittedInsecurePackages = [
              "olm-3.2.16"
              ];
    };
environment.systemPackages =  with pkgs; [
# Text Editors
   emacs
   vim

 # IDE
   jetbrains.idea-community-bin
   zed-editor

 # Git
   git
   lazygit

 # Terminal
   fzf

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
  swaylock
  waybar
  feh
  dwmblocks
  xorg.libxcb
  (sddm-astronaut.override{
    embeddedTheme = "pixel_sakura";
    })
  playerctl

# Audio
  audacity
  #ardour
  reaper
  ncmpcpp
  alsa-utils
  spicetify-cli

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

# Launcher
  rofi-wayland
  rofimoji

# Office
  onlyoffice-bin

# Comunication
  signal-desktop
  qbittorrent
  nheko
  vesktop

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
    material-symbols
    hachimarupop
    monocraft
    maple-mono
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
