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
    jetbrains.idea-community-bin
    vscode-fhs
    mysql-workbench

    # Terminal
    fzf
    alacritty
    lazygit
    fishPlugins.fzf-fish
    krabby

    # Notifications
    libnotify
    mako

    # Web browser
    firefox
    floorp-bin
    librewolf
    vivaldi

    # Wallpapers/windowmanagers
    swww
    matugen
    hyprlock
    wlinhibit
    waybar
    feh
    xorg.libxcb
    playerctl
    inputs.fsel.packages.x86_64-linux.default

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

    # Launcher
    rofi

    # Office
    onlyoffice-bin

    # Comunication
    signal-desktop-bin
    qbittorrent
    vesktop
    parsec-bin
    trayscale

    # File Managers
    nemo-with-extensions
    yazi

    # Games
    protonup-qt
    #steam-run
    prismlauncher
    melonDS
    azahar
    ryubing
    mesen

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
