{ config, lib, pkgs, ... }:

{
    programs.neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        lua-language-server
        pyright
        libclang
        libgcc
        rust-analyzer
        xclip
        wl-clipboard
        nil
        luajitPackages.lua-lsp
        kotlin-language-server
      ];
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        nvim-autopairs
        telescope-nvim
        telescope-fzf-native-nvim
      ];
    };
}
