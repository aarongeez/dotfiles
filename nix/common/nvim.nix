{ pkgs, lib, ... }:
{
  # ~/.config/nvim is managed as an out-of-store symlink to ~/dotfiles/nvim
  # (see xdg.nix), so our own init.lua is authoritative. Stop programs.neovim
  # from writing its generated init.lua, which collides with that symlink
  # (home-manager 26.05 errors: "installing file '.config/nvim/init.lua'
  # outside $HOME"). Plugins are still added to the runtimepath by the neovim
  # wrapper, so our init.lua can require them.
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      plenary-nvim # telescope dependency, no longer pulled in transitively
      telescope-nvim
      nvim-cmp
      cmp-nvim-lsp
      vim-illuminate
      lualine-nvim

      nvim-tree-lua
      nvim-colorizer-lua
      nvim-lspconfig
      luasnip
      vim-sleuth
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      gitsigns-nvim
      fidget-nvim
    ];

    extraPackages = with pkgs; [
      lua-language-server
      nil
      nixd
      zls
    ];
  };
}
