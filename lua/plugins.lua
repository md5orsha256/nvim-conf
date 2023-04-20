local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system(
    {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    }
  )
end


require('packer').startup(function(use)

  use 'wbthomason/packer.nvim' -- Package manager



  -- ---------------------------------------------------------------------------
  -- -- APPEARANCE AND UI
  -- ---------------------------------------------------------------------------

  use 'navarasu/onedark.nvim'  -- Colorscheme

  use 'nvim-tree/nvim-web-devicons'  -- icons
  use {  --statusline
    'nvim-lualine/lualine.nvim',
    requires = {'nvim-tree/nvim-web-devicons', opt = true},
    config = function() require('lualine').setup{} end,
  }

  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
  }

  use {  -- sidebar navigation
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icon
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

  use 'yamatsum/nvim-cursorline'  -- highlights cursor words and lines

  use 'rinx/nvim-minimap'  -- minimap

  use "lukas-reineke/indent-blankline.nvim"  -- indent lines and blocks



  -- ---------------------------------------------------------------------------
  -- -- EDITOR
  -- ---------------------------------------------------------------------------

  use {  -- commnt
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup{} end,
  }

  use "ur4ltz/surround.nvim"  -- surround on `s` key

  use 'cohama/lexima.vim'  -- Auto close parentheses and repeat by dot dot dot...

  use {  -- VS Code-like renaming UI for Neovim, writen in Lua.
    'filipdutescu/renamer.nvim',
    branch = 'master',
    requires = { {'nvim-lua/plenary.nvim'} },
  }
  require('renamer').setup {}

  use "gpanders/editorconfig.nvim"  --  EditorConfig plugin for Neovim


  -- ---------------------------------------------------------------------------
  -- -- GIT
  -- ---------------------------------------------------------------------------

  use {
    'lewis6991/gitsigns.nvim',  -- Git decorations
    config = function() require('gitsigns').setup() end,
}



  -- ---------------------------------------------------------------------------
  -- -- LSP ADN AUTOCOMPLETE
  -- ---------------------------------------------------------------------------

  use {  --  An incremental parsing system for programming tools 
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
}

  use 'hrsh7th/nvim-cmp'  -- A completion engine plugin
  use 'hrsh7th/cmp-nvim-lsp'  -- LSP support for cmp
  use 'hrsh7th/cmp-buffer'  -- nvim-cmp source for filesystem paths
  use 'saadparwaiz1/cmp_luasnip'  -- luasnip completion source for nvim-cmp
  use 'L3MON4D3/LuaSnip'  -- Snippet Engine

  use {  -- tabnine
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp'
}


  if packer_bootstrap then
    require('packer').sync()
  end
end)
