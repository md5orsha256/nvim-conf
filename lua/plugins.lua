local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


require('packer').startup(function(use)

  use 'wbthomason/packer.nvim' -- Package manager



  -- ------------------------------------------------------------------------------------
  -- APPEARANCE AND UI
  -- ------------------------------------------------------------------------------------
  use 'navarasu/onedark.nvim'  -- Colorscheme

  use {  --statusline
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('lualine').setup() end,
  }

  use {  -- tabs
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require("bufferline").setup{} end,
  }

  use {  -- sidebar navigation
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
      opt = true,
    },
    config = function() require'nvim-tree'.setup{} end,
  }

  use {  -- search
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use "mhinz/vim-startify"  -- start page

  use 'nvim-lua/popup.nvim'  -- popup



  -- ---------------------------------------------------------------------------------------
  -- -- EDITOR
  -- ---------------------------------------------------------------------------------------
  use {  -- commnt
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup{} end,
  }

  use "ur4ltz/surround.nvim"  -- surround on `s` key



  -- ---------------------------------------------------------------------------------------
  -- -- LSP
  -- ---------------------------------------------------------------------------------------
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'williamboman/nvim-lsp-installer'  -- Installer for LSP servers



  if packer_bootstrap then
    require('packer').sync()
  end
end)
