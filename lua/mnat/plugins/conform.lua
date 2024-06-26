return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        markdown = { "prettier" },
        lua = { "stylua" },
        ocaml = { "ocamlformat" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        go = { "gofumpt" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        timeout_ms = 1000,
      })
    end, { desc = "[c]ode [f]ormat" })
  end,
}
