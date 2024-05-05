return {
  "alexghergh/nvim-tmux-navigation",
  cmd = {
    "NvimTmuxNavigateLeft",
    "NvimTmuxNavigateDown",
    "NvimTmuxNavigateUp",
    "NvimTmuxNavigateRight",
    "NvimTmuxNavigateLastActive",
    "NvimTmuxNavigateNext",
  },
  opts = {
    disable_when_zoomed = true, -- defaults to false
  },
  keys = {
    { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", mode = "n", desc = "Navigate left split" },
    { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", mode = "n", desc = "Navigate left split" },
    { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", mode = "n", desc = "Navigate left split" },
    { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", mode = "n", desc = "Navigate left split" },
    { "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", mode = "n", desc = "Navigate left split" },
    -- { "<C-Space>", "<cmd>NvimTmuxNavigateNext<cr>",       mode = "n", desc = "Navigate left split" },
  },
}
