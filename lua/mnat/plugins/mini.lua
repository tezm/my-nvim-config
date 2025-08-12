return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Align text interactively
    --
    --  s                 -  enter split Lua pattern.
    --  j                 -  choose justification side from available ones ("left", "center", "right", "none").
    --  m                 -  enter merge delimiter.
    --  f                 -  enter filter Lua expression to configure which parts will be affected (like "align only first column").
    --  i                 -  ignore some commonly unwanted split matches.
    --  p                 -  pair neighboring parts so they be aligned together.
    --  t                 -  trim whitespace from parts.
    --  <BS> (backspace)  -  delete some last pre-step.
    require("mini.align").setup()

    -- Animate common Neovim actions
    require("mini.animate").setup()

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()

    -- Comment lines
    -- - gc  - Normal and Visual modes
    -- - gcc - Toggle comment on current line
    require("mini.comment").setup()

    -- Minimal and fast tabline showing listed buffers
    require("mini.tabline").setup()

    -- Highlight patterns in text
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        error = { pattern = "%f[%w]()ERROR()%f[%W]", group = "DiagnosticError" },
        warning = { pattern = "%f[%w]()WARN()%f[%W]", group = "DiagnosticWarn" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        hint = { pattern = "%f[%w]()HINT()%f[%W]", group = "DiagnosticHint" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        info = { pattern = "%f[%w]()INFO()%f[%W]", group = "DiagnosticInfo" },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    -- Visualize and work with indent scope
    -- - [i - goto top of scope
    -- - ]i - goto bottom of scope
    require("mini.indentscope").setup()

    -- Session management (read, write, delete)
    require("mini.sessions").setup()

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
