{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
   imports = [
    ./package.nix
  ];
  nixpkgs.config = {

    allowUnfree = true;
    permittedInsecurePackages = [
       "olm-3.2.16"
    ];
  };
  environment.systemPackages = with pkgs; [
    # Text Editors
    vim
    neovim
    emacs
    jetbrains.idea
    obsidian
    slidev-cli

    # Terminal
    fzf
    wezterm 
    lazygit
    fishPlugins.fzf-fish
    tmux

    # Notifications
    libnotify
    mako

    # Web browser
    firefox
    inputs.helium.packages.${system}.default

    # Wallpapers/windowmanagers
    awww
    hyprlock
    wlsunset
    wlinhibit
    waybar
    libxcb
    xrdb
    rose-pine-gtk-theme

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
    grim
    slurp
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

    # Comunication
    signal-desktop
    vesktop
    moonlight-qt
    thunderbird
    cinny-desktop

    # File Managers
    nemo-with-extensions
    yazi
    dragon-drop

    # Games
    protonup-qt
    steam-run
    prismlauncher
    mesen
    ryujinx-canary
    #lutris
    shadps4

    # Misc
    icu
    supergfxctl
    gearlever
    appimage-run
    android-tools
    gnupg
    networkmanagerapplet
    wineWow64Packages.waylandFull
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
    wtype
    gtk3
    xclip
    xdotool
    wtype
    libxcb-wm
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
    scrot

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
    keepmenu
    polkit_gnome

    # NUR
    nur.repos.vieb-nix.vieb
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
