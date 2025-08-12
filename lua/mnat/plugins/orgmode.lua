return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-orgmode/telescope-orgmode.nvim",
    "nvim-orgmode/org-bullets.nvim",
    "chipsenkbeil/org-roam.nvim",
  },
  event = "VeryLazy",
  config = function()
    require("orgmode").setup({
      org_agenda_files = "~/notes/**/*",
      org_default_notes_file = "~/notes/refile.org",
    })
    require("org-bullets").setup()
    require("org-roam").setup({
      directory = "~/notes/roam",
      -- optional
      -- org_files = {
      --   "~/another_org_dir",
      --   "~/some/folder/*.org",
      --   "~/a/single/org_file.org",
      -- },
    })
    require("telescope").load_extension("orgmode")
    vim.keymap.set("n", "<leader>r", require("telescope").extensions.orgmode.refile_heading)
    vim.keymap.set("n", "<leader>fh", require("telescope").extensions.orgmode.search_headings)
    vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link)
  end,
}
