-- Map leader keys
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.b.maplocalleader = " "

require("mnat.config.options")
require("mnat.config.lazy")
require("mnat.config.keymaps")
require("mnat.config.autocmds")
require("mnat.config.terminal")

-- vim.cmd("colorscheme gruvbox")
-- vim.cmd([[colorscheme everforest]])
vim.cmd([[colorscheme dracula]])

-- vim.cmd([[TransparentEnable]])
