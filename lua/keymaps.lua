local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- -----------------------------------------------------------------------------
-- NAVIGATION
-- -----------------------------------------------------------------------------

-- DISABLE ARROWS
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})


-- BUFFER NAVIGATION
local get_map_keybinding_for_buffer_number = function(
  buffer_number,  -- integer
  mode  -- string, n | v | i
)
  return map(
    mode,
    't' .. buffer_number,
    '<CMD>BufferLineGoToBuffer ' .. buffer_number .. '<CR>',
    default_opts
  )
end
-- t + <buffer number> - open buffer by number
for buffer_number = 1, 9 do
  get_map_keybinding_for_buffer_number(buffer_number, 'n')
end

-- t + Tab - open next buffer
map('n', 't<Tab>', '<CMD>BufferLineCycleNext<CR>', default_opts)


-- SIDE BAR NAVIGATION
-- t + s - open side bar
map('n', 'ts', '<CMD>NvimTreeToggle<CR>', default_opts)

-- -----------------------------------------------------------------------------
-- EDIT
-- -----------------------------------------------------------------------------

-- RENAME ON SHIFT + F6
map('i', '<F18>', '<cmd>lua require("renamer").rename()<cr>', default_opts)
map('n', '<F18>', '<cmd>lua require("renamer").rename()<cr>', default_opts)
map('v', '<F18>', '<cmd>lua require("renamer").rename()<cr>', default_opts)


map('i', '<C-/>', 'copilot#Accept("<CR>")', {expr=true, silent=true})


-- -----------------------------------------------------------------------------
-- SEARCH
-- -----------------------------------------------------------------------------

map('n', '<C-p>', '<cmd>Telescope<cr>', default_opts)
