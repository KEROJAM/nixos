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
    vim
    jetbrains.idea
    obsidian
    slidev-cli

    # Terminal
    fzf
    kitty
    lazygit
    fishPlugins.fzf-fish
    tmux

    # Notifications
    libnotify
    mako

    # Web browser
    firefox
    vivaldi

    # Wallpapers/windowmanagers
    swww
    hyprlock
    wlsunset
    wlinhibit
    waybar
    libxcb
    xrdb

    # Audio
    #reaper
    alsa-utils
    qpwgraph

    # Video Playback
    mpv
    ffmpeg_6-full
    aegisub
    davinci-resolve

    # Image Editing
    krita
    flameshot
    xnviewmp

    # Education
    jq
    anki
    gnome-calculator
    tesseract
    pandoc

    # Launcher
    rofi

    # Office
    wpsoffice-cn
    onlyoffice-desktopeditors

    # Comunication
    signal-desktop
    vesktop
    moonlight-qt
    thunderbird
    nheko

    # File Managers
    nemo-with-extensions
    yazi
    dragon-drop

    # Games
    protonup-qt
    steam-run
    #heroic
    prismlauncher
    mesen
    shadps4

    # Misc
    supergfxctl
    gearlever
    appimage-run
    android-tools
    gnupg
    networkmanagerapplet
    wineWow64Packages.stable
    findutils
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
    wtype
    xcbutilwm
    lsd
    bat
    tldr
    gparted
    glib
    btop
    xdg-utils
    lzip
    unzip
    xf86inputlibinput
    nwg-look
    acpi

    # Virtualisation
    virt-manager
    virtiofsd

    # Languages
    ispell
    python3
    go
    multimarkdown

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
      undefined-medium
      pixel-code
      monaspace
      cozette
      nerd-fonts.mononoki
      material-symbols
      hachimarupop
      rounded-mgenplus
      google-fonts
      corefonts
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
