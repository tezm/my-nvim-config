return {
   "folke/todo-comments.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },
   opts = {
      colors = {
         error = { "DiagnosticError", "ErrorMsg", "#f85552" },
         warning = { "DiagnosticWarn", "WarningMsg", "#f57d26" },
         info = { "DiagnosticInfo", "#3a94c5" },
         hint = { "DiagnosticHint", "#8da101" },
         default = { "Identifier", "#35A77c" },
         test = { "Identifier", "#df69ba" },
      },
   },
}
