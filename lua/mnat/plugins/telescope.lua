return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function ()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    telescope.load_extension("media_files")

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = {"png", "webp", "jpg", "jpeg"},
          -- find command (defaults to `fd`)
          find_cmd = "rg"
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(telescope.load_extension, "fzf")
    -- Enable telescope media files previewer, if installed

    local keymap = vim.keymap.set

    -- See `:help telescope.builtin`
    keymap('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    keymap('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    keymap('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    keymap('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    keymap('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    keymap('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    keymap('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    keymap('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
  end
}

