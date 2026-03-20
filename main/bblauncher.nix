{
   lib,
   fetchzip,
   appimageTools,
   makeWrapper,
}:

let
   pname = "bb-launcher";
   version = "Release13.06";

   src = {
      x86_64-linux = fetchzip {
         url = "https://github.com/rainmakerv3/BB_Launcher/releases/download/${version}/BB_Launcher-linux-qt-2026-02-28-bc91ce2.zip";
         hash = "";
         stripRoot = false;
      };
  };

  meta = {
   description = "Dedicated launcher/mod manager combo app for Bloodborne on shadPS4 ";
   homepage = "https://github.com/rainmakerv3/BB_Launcher";
   };
   passthru.updateScript = ./update.sh;
   in
   appimageTools.wrapType2 {
      inherit
         pname
         version
         src
         meta
         passthru
      ;
      extraInstallCommands = { 
      let
         contents = appimageTools.extract { inherit  pname version src; };
      in
      ''
         .${makeWrapper}/nix-support/setup-hook
         mv -v $out/bin/${pname} $out/bin/bblauncher

         wrapProgram $out/bin/bblauncher

         install -m 444

      ''
      };
   };
