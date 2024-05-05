return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = { query = "@assignment.outer", desc = "Select [a] outer part of an [a]ssignment region" },
            ["ia"] = { query = "@assignment.inner", desc = "Select [i]nner part of an [a]ssignment region" },

            ["a:"] = { query = "@parameter.outer", desc = "Select [a] outer part of a [:] parameter/field region" },
            ["i:"] = { query = "@parameter.inner", desc = "Select [i]nner part of a [:] parameter/field region" },

            ["ai"] = { query = "@conditional.outer", desc = "Select [a] outer part of a [i]f/conditional region" },
            ["ii"] = { query = "@conditional.inner", desc = "Select [i]nner part of a [i]f/conditional region" },

            ["ar"] = { query = "@loop.outer", desc = "Select [a] outer part of a loop [r]egion" },
            ["ir"] = { query = "@loop.inner", desc = "Select [i]nner part of a loop [r]egion" },

            ["ab"] = { query = "@block.outer", desc = "Select [a] outer part of a [b]lock region" }, -- overrides default text object block of parenthesis to parenthesis
            ["ib"] = { query = "@block.inner", desc = "Select [i]nner part of a [b]lock region" },   -- overrides default text object block of parenthesis to parenthesis

            ["af"] = { query = "@function.outer", desc = "Select [a] outer part of a [f]unction region" },
            ["if"] = { query = "@function.inner", desc = "Select [i]nner part of a [f]unction region" },

            ["ac"] = { query = "@class.outer", desc = "Select [a] outer part of a [c]lass region" },
            ["ic"] = { query = "@class.inner", desc = "Select [i]nner part of a [c]lass region" },
          },
          include_surrounding_whitespace = false,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = { query = "@parameter.inner", desc = "[s]wap with [n]ext parameter" },
          },
          swap_previous = {
            ["<leader>sp"] = { query = "@parameter.inner", desc = "[s]wap with [p]revious parameter" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        lsp_interop = {
          enable = true,
          border = "rounded",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
    })
  end,
}
