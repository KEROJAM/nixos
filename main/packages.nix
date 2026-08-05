{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
    ${coreutils}/bin/mkdir -p $out/share/applications
    ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
  '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in

{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
      "pnpm-10.29.2"
      "electron-40.10.5"
    ];
  };
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ./ryujinx-canary.nix { })
    # Text Editors
    vim
    #jetbrains.idea

    # Terminal
    fzf
    wezterm 
    lazygit
    tmux

    # Notifications
    libnotify
    mako

    # Web browser
    librewolf
    ungoogled-chromium
    
    # Wallpapers/windowmanagers
    awww
    hyprlock
    wlinhibit
    waybar
    libxcb
    xrdb

    # Audio
    reaper
    #kew
    audacity
    alsa-utils
    ncpamixer
    qpwgraph

    # Video Playback
    mpv
    ffmpeg_6-full
    aegisub
    davinci-resolve

    # Image Editing
    krita
    flameshot
    grim
    slurp
    wayfreeze
    xnviewmp

    # Education
    jq
    #anki
    gnome-calculator
    tesseract
    pandoc
    imagemagick
    texliveFull

    # Launcher
    rofi

    # Office
    onlyoffice-desktopeditors

    # Comunication
    signal-desktop
    vesktop
    moonlight-qt

    # File Managers
    nemo-with-extensions
    yazi
    dragon-drop

    # Games
    #(GPUOffloadApp steam "steam")
    steam-run
    prismlauncher
    mesen
    azahar
    #dolphin-emu
    #lutris
    #shadps4

    # Misc
    icu
    supergfxctl
    gearlever
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
    ydotool
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
    markdownlint-cli
    
    # Important
    keepassxc
    keepmenu
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
