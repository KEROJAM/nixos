{ config, lib, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
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
        (nvim-treesitter.withPlugins (p: [
          p.nix
          p.bash
          p.lua
          p.python
          p.json
          p.go
          p.rust
          p.typescript
          p.css
          p.make
          p.markdown
          p.toml
          p.yaml
        ]))
      ];
    };
  };
}
