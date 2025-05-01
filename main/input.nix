{ inputs, config, pkgs, ... }:

{
# Set your time zone.
  time.timeZone = "America/Monterrey";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
	fcitx5-mozc
	  fcitx5-gtk
	  fcitx5-rose-pine
      ];
      waylandFrontend = true;
      settings.inputMethod = {
	"keyboard-us" = {
	  "KeyDelay" = 0;
	};
	"keyboard-latam" = {
	  "KeyDelay" = 0;
	};
	"mozc" = {
	  "ActivateOnLaunch" = true;
            "CompositionMode" = "Direct";
            "PreeditMethod" = "Roman";
            "Display/AsciiMode" = "HalfWidthAlphanumeric";
            "Display/CandidateWindowStyle" = "Vertical";
	};
      };
    };
  };
}
