{
  lib,
  stdenv,
  fetchurl,
  libx11,
  libgdiplus,
  moltenvk,
  ffmpeg,
  openal,
  libsoundio,
  sndio,
  pulseaudio,
  vulkan-loader,
  glew,
  libGL,
  libice,
  libsm,
  libxcursor,
  libxext,
  libxi,
  libxrandr,
  udev,
  SDL2,
  SDL2_mixer,
  gtk3,
  libusb1,
  jack2,
  pipewire,
  libXtst,
  libXScrnSaver,
  libdrm,
  libdecor,
  libglvnd,
  icu,
  fontconfig,
}:

stdenv.mkDerivation rec {
  pname = "ryujinx-canary";
  version = "1.3.279";

  src = fetchurl {
    url = "https://git.ryujinx.app/Ryubing/Canary/releases/download/${version}/ryujinx-canary-${version}-linux_x64.tar.gz";
    sha256 = "6DO0z/r0oKQOLee+2TAZxq1ykBn8AdKyV3T48Uhf0uI=";
  };

  nativeBuildInputs = [];

  runtimeDeps = [
    icu
    fontconfig
    libx11
    libgdiplus
    SDL2_mixer
    openal
    libsoundio
    sndio
    vulkan-loader
    ffmpeg
    libusb1
    jack2
    pipewire
    pulseaudio
    libXtst
    libXScrnSaver
    libdrm
    libdecor
    libglvnd

    # Avalonia UI
    glew
    libice
    libsm
    libxcursor
    libxext
    libxi
    libxrandr
    gtk3

    # Headless executable
    libGL
    SDL2

    udev
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ./* $out/

    mkdir -p $out/bin

    cat > $out/bin/ryujinx << 'EOF'
#!/bin/sh
export SDL_VIDEODRIVER=x11
export DOTNET_BUNDLE_EXTRACT_BASE_DIR=/tmp
export LD_LIBRARY_PATH=${lib.makeLibraryPath runtimeDeps}:${placeholder "out"}:$LD_LIBRARY_PATH
exec ${placeholder "out"}/Ryujinx "$@"
EOF

    chmod +x $out/bin/ryujinx
    ln -s $out/bin/ryujinx $out/bin/Ryujinx

    runHook postInstall
  '';

  preFixup = ''
    mkdir -p $out/lib/sndio-6
    ln -s ${sndio}/lib/libsndio.so $out/lib/sndio-6/libsndio.so.6
  '';

  meta = {
    homepage = "https://ryujinx.app";
    description = "Experimental Nintendo Switch Emulator written in C# (Canary builds)";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "Ryujinx";
  };
}
