return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs                        = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
      follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
      -- Options passed to nvim_open_win
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    yadm                         = {
      enable = false
    },
    on_attach                    = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = "Next hunk" })

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = "Prev hunk" })

      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, { desc = "Hunk stage" })
      map('n', '<leader>hr', gs.reset_hunk, { desc = "Hunk reset" })
      map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Hunk stage" })
      map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Hunk reset" })
      map('n', '<leader>hS', gs.stage_buffer, { desc = "Bufer stage" })
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undu stage hunk" })
      map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
      map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
      map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Blame line" })
      map('n', '<leader>htb', gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
      map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
      map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this" })
      map('n', '<leader>htd', gs.toggle_deleted, { desc = "Toggle delete" })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns select hunk" })
    end
  }
}
