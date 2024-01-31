-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Map leader keys
keymap({ 'n', 'v' }, '<Space>', '<Nop>', default_opts)
vim.g.mapleader = " "
vim.b.maplocalleader = " "

-- Add aditional keymaps here

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Remap for closing current buffer
keymap('n', '<leader>bd', ':Bdelete<CR>', default_opts)
-- Lua
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
