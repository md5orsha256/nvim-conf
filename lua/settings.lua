local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options



-- -----------------------------------------------------------------------------
-- APPEARANCE
-- -----------------------------------------------------------------------------
opt.termguicolors = true        --  24-bit RGB colors

local colors = {
  dirty_green = "#637958",
  subtle_gray = "#504f4c",
}

require('onedark').setup {
  style = 'warm',
  highlights = {
    Comment = {fg = colors.dirty_green},
    NonText = {fg = colors.subtle_gray},
    Whitespace = {fg = colors.subtle_gray},
  },
}
require('onedark').load()



-- -----------------------------------------------------------------------------
-- EDITOR
-- -----------------------------------------------------------------------------

-- display number of line
opt.number = true
opt.relativenumber = true

-- line width (in characters)
opt.colorcolumn = '80'

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
