return {
  "tpope/vim-dadbod",
  opt = true,
  requires = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  config = function()
    require("mnat.config.dadbod").setup()
  end,
}
