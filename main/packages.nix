{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
#let
#  ciscoPacketTracer9 = pkgs.callPackage (import ./ciscoPacketTracer9.nix) { };
#in
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

    # Terminal
    fzf
    ghostty
    lazygit
    fishPlugins.fzf-fish
    tmux

    # Notifications
    libnotify
    mako

    # Web browser
    inputs.zen-browser.packages."${system}".default
    inputs.helium.packages."${system}".default
    vivaldi

    # Wallpapers/windowmanagers
    swww
    matugen
    hyprlock
    hyprpicker
    wlsunset
    wlinhibit
    waybar
    xorg.libxcb

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
    (blender.override { cudaSupport = true; })

    # Education
    jq
    anki
    grim
    slurp
    gnome-calculator
    tesseract
    #ciscoPacketTracer9

    # Launcher
    rofi
    rofimoji

    # Office
    onlyoffice-desktopeditors

    # Comunication
    signal-desktop-bin
    vesktop
    trayscale
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
    heroic
    prismlauncher
    mesen

    # Coding
    caddy

    # Misc
    gnupg
    cudaPackages.cudatoolkit
    networkmanagerapplet
    wineWowPackages.stable
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
    xorg.xcbutilwm
    lsd
    bat
    tldr
    gparted
    glib
    btop
    xdg-utils
    lzip
    unzip
    xorg.xf86inputlibinput
    nwg-look
    papirus-icon-theme
    everforest-gtk-theme
    acpi

    # Virtualisation
    virt-manager
    virtiofsd

    # Languages
    ispell
    hunspell
    hunspellDicts.es_MX
    hunspellDicts.en_US
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
      ark-pixel-font
      undefined-medium
      pixel-code
      monaspace
      cozette
      nerd-fonts.mononoki
      material-symbols
      hachimarupop
      rounded-mgenplus
      google-fonts
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
