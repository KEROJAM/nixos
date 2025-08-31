{
  lib,
  stdenv,
  fetchurl,

  dpkg,
  autoPatchelfHook,
  pkg-config,

  libxkbcommon,
  libxcb,
  xorg,
  alsa-lib,
  nss,
  at-spi2-core,
  mesa,
  cairo,
  pango,
  cups,
  gtk3,
  pipewire,
  glib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "min";
  version = "1.35.1";

  src = fetchurl {
    url = "https://github.com/minbrowser/min/releases/download/v${finalAttrs.version}/min-${finalAttrs.version}-amd64.deb";
    hash = "sha256-RTHh9Ntgh4uEjE+gbc1m2la7JRo56LoE+dQraAOSC7s=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    libxkbcommon # libxkbcommon.so
    libxcb # libxcb.so
    at-spi2-core # libatspi.so
    mesa # libdbm.so libexpat.so
    cairo # libcairo.so
    cups # libcups.so
    gtk3 # libgtk-3.so
    pango # libpango-1.0.so
    (with xorg; [
      libX11 # libX11.so
      libXcomposite # libXcomposite.so
      libXdamage # libXdamage.so
      libXext # libXext.so
      libXfixes # libXfixes.so
      libXrandr # libXrandr.so
    ])
    nss # libnss3.so
    alsa-lib # libasound.so
    glib # libglib-2.0.so libgobject-2.0.so libgio.so
    stdenv.cc.cc.lib # libgcc_s.so
  ];

  unpackPhase = "dpkg-deb -x $src $out";

  meta = with lib; {
    description = "A fast, minimal browser that protects your privacy";
    homepage = "https://github.com/minbrowser/min";
    license = licenses.asl20;
    maintainers = with maintainers; [ kashw2 ];
  };
})
