return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({
        -- ensure these language parsers are installed
        ensure_installed = {
          "c",
          "cpp",
          "go",
          "python",
          "rust",
          "vimdoc",
          "ocaml",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
        },
        -- enable syntax highlighting
        highlight = { enable = true },
        -- enable indentation
        indent = { enable = true, disable = { "python" } },
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
}
