return {
  "Vonr/align.nvim",
  branch = "v2",
  lazy = true,
  init = function()
    -- Shorten function name
    local keymap = vim.keymap.set

    -- Silent keymap option
    local default_opts = { noremap = true, silent = true }

    local align = require("align")

    -- Align to 1 character
    keymap("x", "aa", function()
      align.align_to_char({ length = 1 })
    end, default_opts)

    -- Align to 2 character with preview
    keymap("x", "ad", function()
      align.align_to_char({ preview = true, length = 2 })
    end, default_opts)

    -- Align to a string with previews
    keymap("x", "aw", function()
      align.align_to_string({ preview = true, regex = false })
    end, default_opts)

    -- Align to a VIM regex with previews
    keymap("x", "ar", function()
      align.align_to_string({ preview = true, regex = true })
    end, default_opts)

    -- Align to a VIM regex with previews
    keymap("n", "gaw", function()
      align.operator(align.align_to_string({ preview = true, regex = false }))
    end, default_opts)
  end,
}
