-- Shorten function name
local keymap = vim.keymap.set
local k = vim.keycode

-- Silent keymap option
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Map leader keys
keymap({ "n", "v" }, "<Space>", "<Nop>", default_opts)
vim.g.mapleader = " "
vim.b.maplocalleader = " "

-- Add aditional keymaps here

-- Remap for dealing with word wrap

-- Basic movement keybinds, these make navigating splits easy for me
-- keymap("n", "<c-j>", "<c-w><c-j>")
-- keymap("n", "<c-k>", "<c-w><c-k>")
-- keymap("n", "<c-l>", "<c-w><c-l>")
-- keymap("n", "<c-h>", "<c-w><c-h>")

-- keymap("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
-- keymap("v", "<leader>x", "<cmd>lua<CR>", { desc = "Execute the current selection" })
-- keymap("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Toggle hlsearch if it's on, otherwise just do "enter"
keymap("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.v.hlsearch == 1 then
    vim.cmd.nohl()
    return ""
  else
    return k("<CR>")
  end
end, { expr = true })

keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Remap for closing current buffer
keymap("n", "<leader>bd", ":Bdelete<CR>", { noremap = true, silent = true, desc = "[b]uffer [d]elete" })
keymap("n", "]b", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "[b", ":bNext<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
-- Lua
keymap("n", "<leader>xx", function()
  require("trouble").toggle()
end)
keymap("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end)
keymap("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end)
keymap("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
keymap("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end)
keymap("n", "gR", function()
  require("trouble").toggle("lsp_references")
end)

-- These mappings control the size of splits (height/width)
keymap("n", "<M-,>", "<c-w>5<")
keymap("n", "<M-.>", "<c-w>5>")
keymap("n", "<M-t>", "<C-W>+")
keymap("n", "<M-s>", "<C-W>-")

keymap("n", "<M-j>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! ]c]])
  else
    vim.cmd([[m .+1<CR>==]])
  end
end)

keymap("n", "<M-k>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! [c]])
  else
    vim.cmd([[m .-2<CR>==]])
  end
end)

keymap("n", "<space>tt", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end)

-- exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. otherwise, you normally need to press <c-\><c-n>, which
-- is not what someone will guess without a bit more experience.
--
-- note: this won't work in all terminal emulators/tmux/etc. try your own mapping
-- or just use <c-\><c-n> to exit terminal mode
keymap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exit terminal mode" })

-- tip: disable arrow keys in normal mode
keymap("n", "<left>", '<cmd>echo "use h to move!!"<cr>')
keymap("n", "<right>", '<cmd>echo "use l to move!!"<cr>')
keymap("n", "<up>", '<cmd>echo "use k to move!!"<cr>')
keymap("n", "<down>", '<cmd>echo "use j to move!!"<cr>')
