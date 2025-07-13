{ config, lib, pkgs, ... }:

{
    programs.neovim = {
      enable = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        lua-language-server
        pyright
        libclang
        clang-tools
        libgcc
        rust-analyzer
        jdt-language-server
        xclip
        wl-clipboard
        nil
        luajitPackages.lua-lsp
        kotlin-language-server
        hyprls
      ];
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        nvim-autopairs
        telescope-nvim
        telescope-fzf-native-nvim
        luasnip
        yazi-nvim
      ];
      extraLuaConfig = ''
        ${builtins.readFile ../.config/nvim/init.lua}
      '';
    };
}
