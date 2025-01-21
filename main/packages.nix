{ config, lib, pkgs, inputs, ... }:


{

  nixpkgs.config = {
    
    allowUnfree = true;

            permittedInsecurePackages = [
                "python-2.7.18.6"
              ];
    };
environment.systemPackages =  with pkgs; [
# Text Editors
   emacs
   vim

 # IDE
   #rstudio
   vscode-fhs
   jetbrains.idea-community-bin

 # Git
   git
   lazygit

 # Terminal
   alacritty
   kitty
   zoxide
   fzf
   starship
   tmux

 # Notifications
   libnotify
   mako
   dunst
   inotify-tools

 # Web browser
   firefox
   librewolf
   chromium

# Wallpapers/windowmanagers
  swww
  feh
  dwmblocks
  waybar
  yambar
  xorg.libxcb
  sddm-astronaut

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
  maim
  slop
  flameshot
  imagemagick

# Education
  jq
  anki
  gnome-calculator

# Launcher
  rofi-wayland

# Office
  onlyoffice-bin

# Comunication
  signal-desktop
  remmina
  qbittorrent

# File Managers
  nemo-with-extensions
  yazi

# Games
  protonup-qt
  steam-run
  mangohud
  prismlauncher
  heroic
  osu-lazer-bin
  pcsx2
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
  dbus
  xdg-utils
  lzip
  unzip
  xorg.xf86inputlibinput
  lxappearance
  papirus-icon-theme
  acpi
  pamixer
  emojify

# Virtualisation
  virt-manager
  virtiofsd

# Languages
  luajit
  ispell
  python3

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
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.mononoki
    nerd-fonts.jetbrains-mono
    nerd-fonts.space-mono
    material-symbols
    cozette
    azuki
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
