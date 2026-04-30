{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./nvim.nix
    ./terminal.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kerojam";
  home.homeDirectory = "/home/kerojam";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "KEROJAM";
        email = "majorekcs@hotmail.com";
      };
      signing.format = "openpgp";
    };
    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle # shuffle+ (special characters are sanitized out of extension names)
        ];
        theme = spicePkgs.themes.comfy;
        colorScheme = "rose-pine-dawn";
      };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
