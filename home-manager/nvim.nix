{ config, lib, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      extraPackages = with pkgs; [
        lua-language-server
        pyright
        libclang
        rust-analyzer
      ];
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        nvim-autopairs
        telescope-nvim
        telescope-fzf-native-nvim
      ];
    };
  };
}
