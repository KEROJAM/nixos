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
    ];
  };

  environment.systemPackages = with pkgs; [
    #(pkgs.callPackage ./ryujinx-canary.nix { })
    (pkgs.callPackage ./yabridge.nix {})
    (pkgs.callPackage ./yabridgectl.nix {})
    # Text Editors
    vim
    emacsPackages.vterm
    #(llama-cpp.override { cudaSupport = true; })

    # Terminal
    fzf
    lazygit
    foot 
    zoxide
    tmux
    git
    zathura
 
    # Notifications
    libnotify
    mako

    # Web browser
    librewolf
 
    # Wallpapers/windowmanagers
    awww
    hyprlock
    wlinhibit
    waybar
    libxcb
    xrdb

    # Audio
    reaper
    alsa-utils
    #ncpamixer
    qpwgraph

    # Video Playback
    mpv
    ffmpeg_6-full
    #aegisub
    davinci-resolve

    # Image Editing
    krita
    #flameshot
    inputs.focal.packages.${pkgs.system}.default
    xnviewmp
    #aseprite
    
    # Education
    jq
    anki
    tesseract
    pandoc
    imagemagick
    texliveFull

    # Launcher
    rofi

    # Office
    onlyoffice-desktopeditors

    # Comunication
    vesktop
    #moonlight-qt

    # File Managers
    nemo-with-extensions
    yazi
    dragon-drop

    # Games
    steam-run
    prismlauncher
    #mesen
    #azahar
    #dolphin-emu
    #lutris
    #shadps4

    # Misc
    icu
    #gearlever
    android-tools
    gnupg
    wineWow64Packages.waylandFull
    dxvk
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
    xclip
    libxcb-wm
    eza
    bat
    tldr
    gparted
    glib
    btop
    xdg-utils
    lzip
    unzip
    unrar
    xf86inputlibinput
    nwg-look
    acpi
    scrot
    ispell
    nixd
    python3

    # Virtualisation
    virt-manager
    virtiofsd

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
      nerd-fonts.annotationmono
      nerd-fonts.monofur
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
