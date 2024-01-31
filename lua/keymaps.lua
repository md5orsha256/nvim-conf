local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

local nmap = function(key, cmd, opts)
  map('n', key, cmd, opts or default_opts)
end

local imap = function(key, cmd, opts)
  map('i', key, cmd, opts or default_opts)
end

local vmap = function(key, cmd, opts)
  map('v', key, cmd, opts or default_opts)
end


-- -----------------------------------------------------------------------------
-- GENERAL
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- NAVIGATION
-- -----------------------------------------------------------------------------

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
nmap('t<Tab>', '<CMD>BufferLineCycleNext<CR>')


-- SIDE BAR NAVIGATION
-- t + s - open side bar
nmap('ts', '<CMD>NvimTreeToggle<CR>')
nmap("tw", "<CMD>NvimTreeFocus<CR>")

-- -----------------------------------------------------------------------------
-- EDIT
-- -----------------------------------------------------------------------------

-- RENAME ON SHIFT + F6
imap('<F18>', '<cmd>lua require("renamer").rename()<cr>')
nmap('<F18>', '<cmd>lua require("renamer").rename()<cr>')
vmap('<F18>', '<cmd>lua require("renamer").rename()<cr>')


imap('<S-right>', 'copilot#Accept("<CR>")', {expr=true, silent=true})


-- -----------------------------------------------------------------------------
-- SEARCH
-- -----------------------------------------------------------------------------

nmap('<C-p>', '<cmd>Telescope find_files<cr>')
nmap("<C-S-p>", "<cmd>Telescope live_grep<cr>")


nmap('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
nmap('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
nmap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
nmap('#', [[#<Cmd>lua require('hlslens').start()<CR>]])
nmap('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
nmap('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])
nmap('<Leader>l', '<Cmd>noh<CR>')
