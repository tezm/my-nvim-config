return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Bigfile adds a new filetype bigfile to Neovim that triggers when the file is larger than the configured size.
    -- This automatically prevents things like LSP and Treesitter attaching to the buffer.
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    image = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    -- Quickfile - When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins.
    quickfile = { enabled = true },
    -- Smooth scrolling for Neovim. Properly handles scrolloff and mouse scrolling.
    scroll = { enabled = true },
    -- Plugins provide window styles that can be customized with the opts.styles option of snacks.nvim.
    styles = { enabled = true },
  },
  keys = {
    {
      "<leader>lg",
      function()
        require("snacks").lazygit()
      end,
      desc = "[L]azy[g]it",
    },
    {
      "<leader>lgl",
      function()
        require("snacks").lazygit.log()
      end,
      desc = "[L]azy[g]it [L]og",
    },
  },
}
