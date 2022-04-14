local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options



-- -----------------------------------------------------------------------------
-- APPEARANCE AND UI
-- -----------------------------------------------------------------------------
opt.termguicolors = true        --  24-bit RGB colors

local colors = {
  dirty_green = "#637958",
  subtle_gray = "#504f4c",
}

require('onedark').setup {
  style = 'warmer',
  highlights = {
    Comment = {fg = colors.dirty_green},
    NonText = {fg = colors.subtle_gray},
    Whitespace = {fg = colors.subtle_gray},
  },
}
require('onedark').load()

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.nvim_tree_highlight_opened_files = 1
opt.termguicolors = true

require('nvim-tree').setup {  -- SIDEBAR NAVIGATION CONFIG
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  open_on_tab = true,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = true,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}


require("bufferline").setup {  -- TABS CONFIG
    options = {
      indicator = {
        icon = "▎"
      },
      modified_icon = "●",
      buffer_close_icon = "",
      close_icon = "",
      left_trunc_marker = "... ",
      right_trunc_marker = " ...",
      numbers = "ordinal",
      max_name_length = 15,
      max_prefix_length = 6,
      diagnostics = "nvim_lsp",
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      persist_buffer_sort = true,
      enforce_regular_tabs = true,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and "" or ""
        return icon .. count
      end,
    },
}


require('nvim-cursorline').setup {  -- cursorline
  cursorline = {
    enable = true,
    timeout = 300,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 2,
    hl = { underline = true },
  }
}


-- -----------------------------------------------------------------------------
-- EDITOR
-- -----------------------------------------------------------------------------

-- display number of line
opt.number = true
opt.relativenumber = true

-- Set a width to show a column after texwidth (editroconfig)
opt.colorcolumn = "+1"

-- whitespaces
opt.listchars:append({
  tab = ">-",
  extends = '⟩',
  precedes = '⟨',
  trail = "~",
  nbsp = "␣",
  space = "·"
})
opt.list = true

require"surround".setup {
  mappings_style = "surround"
}

-- memorize las cursor position
cmd [[
  autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]]


-- -----------------------------------------------------------------------------
-- GIT
-- -----------------------------------------------------------------------------

require('gitsigns').setup {
  signs = {

    add = {
      hl = 'GitSignsAdd',
      text = '│',
      numhl='GitSignsAddNr',
      linehl='GitSignsAddLn'
    },

    change = {
      hl = 'GitSignsChange',
      text = '│',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn'
    },

    delete = {
      hl = 'GitSignsDelete',
      text = '▶',
      numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn'
    },

    topdelete = {
      hl = 'GitSignsDelete',
      text = '‾',
      numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn'
    },

    changedelete = {
      hl = 'GitSignsChange',
      text = '~',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn'
    },

  },

  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },

  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '    <author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 10,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}


-- -----------------------------------------------------------------------------
--  -- LSP AND COMPLETION
--  ----------------------------------------------------------------------------
require("mason").setup{}
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "ansiblels",
    "angularls",
    "bashls",
    "cmake",
    "cssls",
    "dockerls",
    "docker_compose_language_service",
    "elixirls",
    "emmet_ls",
    "html",
    "jsonls",
    "marksman",
    "pyright",
    "ruff_lsp",
    "sqlls",
    "yamlls"
  }
}

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'cmp_tabnine' },
    {
      name = 'buffer', options = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      },
    },
  },

  -- TODO: Transfer mappings to `keymap.lua`
  mapping = {
    ['<C-g>'] = cmp.mapping(function(fallback)
        vim.api.nvim_feedkeys(
          vim.fn['copilot#Accept'](
            vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
          ), 'n', true
        )
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  experimental = {
    ghost_text = false -- this feature conflict to the copilot.vim's preview.
  },
}


-- cmp_tabnine configuration
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_lines = 1000;
  max_num_results = 20;
  sort = true;
  run_on_every_keystroke = true;
  snippet_placeholder = '..';
  ignored_file_types = { -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  };
  show_prediction_strength = false;
})
