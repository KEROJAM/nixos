{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  ciscoPacketTracer9 = import ./ciscoPacketTracer9.nix { inherit pkgs; };
in
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
    glow

    # IDE
    jetbrains.idea-community-bin
    vscode-fhs
    mysql-workbench

    # Terminal
    fzf
    alacritty
    wezterm
    lazygit
    fishPlugins.fzf-fish
    doxx
    termshark

    # Notifications
    libnotify
    mako

    # Web browser
    firefox
    librewolf
    vivaldi

    # Wallpapers/windowmanagers
    swww
    matugen
    hyprlock
    wlinhibit
    waybar
    xorg.libxcb
    playerctl

    # Audio
    ardour
    #reaper
    ncmpcpp
    alsa-utils
    qpwgraph

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
    xnviewmp

    # Education
    jq
    anki-bin
    gnome-calculator
    tesseract
    zathura
    ciscoPacketTracer9

    # Launcher
    rofi

    # Office
    onlyoffice-desktopeditors

    # Comunication
    signal-desktop-bin
    qbittorrent
    vesktop
    parsec-bin
    trayscale

    # File Managers
    nemo-with-extensions
    yazi
    superfile
    # Games
    protonup-qt
    #steam-run
    prismlauncher
    melonDS
    azahar
    ryubing
    mesen
    osu-lazer-bin

    # Misc
    gnupg
    networkmanagerapplet
    wineWowPackages.stable
    findutils
    libsForQt5.qt5.qtgraphicaleffects
    trash-cli
    udiskie
    wireplumber
    pavucontrol
    brightnessctl
    krabby
    fastfetch
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
    nwg-look
    papirus-icon-theme
    rose-pine-gtk-theme
    acpi

    # Virtualisation
    virt-manager
    virtiofsd

    # Languages
    ispell
    python3
    go

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
      ark-pixel-font
      monaspace
      nerd-fonts.mononoki
      material-symbols
      monocraft
      miracode
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
