{ config, lib, pkgs, inputs, ... }:


{

  nixpkgs.config.allowUnfree = true;

            nixpkgs.config.permittedInsecurePackages = [
                "python-2.7.18.6"
              ];


environment.systemPackages =  with pkgs; [
# Text Editors
   emacs
   vim

 # IDE
   rstudio
   vscode-fhs

 # Git
   git

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
   google-chrome

# Wallpapers/windowmanagers
  swww
  feh
  dwmblocks
  slstatus
  waybar
  xorg.libxcb

# Audio
  audacity
  #deadbeef
  ardour
  reaper
  ncmpcpp
  alsa-utils

# Video Playback
  mpv
  vlc
  ffmpeg_6-full
  obs-studio
  (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      #obs-studio-plugins.obs-vkcapture
    ];
  })
  aegisub
  yt-dlp
  davinci-resolve

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
  gnome-calculator

# Launcher
  rofi-wayland

# Office
  onlyoffice-bin

# Comunication
  vesktop
  signal-desktop
  parsec-bin
  remmina

# File Managers
  nemo-with-extensions
  yazi

# Games
  protonup-qt
  protonup
  steam
  steam-run
  mangohud
  weston
  waydroid
  prismlauncher
  heroic
  osu-lazer-bin
  pcsx2

# Misc
  appimage-run
  trash-cli
  udiskie
  wireplumber
  pavucontrol
  brightnessctl
  neofetch
  fastfetch
  cbonsai
  wget
  ripgrep
  fd
  wl-clipboard
  wf-recorder
  bun
  dart-sass
  pywal
  fd
  swappy
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
  libinput
  lxappearance
  home-manager
  papirus-icon-theme
  acpi
  brightnessctl
  ncmpcpp
  pamixer
  cairo
  inputs.matugen.packages.${system}.default

# Virtualisation
  virt-manager
  virtiofsd
  qemu_full

# Languages
  #cmake
  luajit
  ispell
  python3

# Important
  keepassxc
  syncthing
  polkit_gnome

# NUR
 # config.nur.repos.ataraxiasjel.waydroid-script

 ];

  # Fonts
fonts = {
  packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.mononoki
    cozette
  ];
  fontDir.enable = true;
  };

}
