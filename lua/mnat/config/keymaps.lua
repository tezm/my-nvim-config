-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
---@diagnostic disable-next-line: unused-local
local opts = { silent = true, noremap = true }

-- Map leader keys
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = " "
vim.b.maplocalleader = " "

-- Add aditional keymaps here

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
