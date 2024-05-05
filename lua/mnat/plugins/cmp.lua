---@diagnostic disable: missing-fields
return {
   "hrsh7th/nvim-cmp",
   event = "InsertEnter",
   dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      {
         "L3MON4D3/LuaSnip",
         build = (function()
            -- Build Step is needed for regex support in snippets
            -- This step is not supported in many windows environments
            -- Remove the below condition to re-enable on windows
            if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
               return
            end
            return "make install_jsregexp"
         end)(),
      },
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim", -- vs-code like pictograms
   },
   config = function()
      local cmp = require("cmp")

      local luasnip = require("luasnip")

      local lspkind = require("lspkind")

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
         completion = {
            completeopt = "menu,menuone,preview,noselect",
         },
         snippet = { -- configure how nvim-cmp interacts with snippet engine
            expand = function(args)
               luasnip.lsp_expand(args.body)
            end,
         },
         mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.abort(), -- close completion window
            -- Select the [n]ext item
            ["<C-n>"] = cmp.mapping.select_next_item(),
            -- Select the [p]revious item
            ["<C-p>"] = cmp.mapping.select_prev_item(),

            -- Accept ([y]es) the completion.
            --  This will auto-import if your LSP supports it.
            --  This will expand snippets if the LSP sent a snippet.
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),

            -- Manually trigger a completion from nvim-cmp.
            --  Generally you don't need this, because nvim-cmp will display
            --  completions whenever it has completion options available.
            ["<C-Space>"] = cmp.mapping.complete({}),

            -- Think of <c-l> as moving to the right of your snippet expansion.
            --  So if you have a snippet that's like:
            --  function $name($args)
            --    $body
            --  end
            --
            -- <c-l> will move you to the right of each of the expansion locations.
            -- <c-h> is similar, except moving you backwards.
            ["<C-l>"] = cmp.mapping(function()
               if luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
               end
            end, { "i", "s" }),
            ["<C-h>"] = cmp.mapping(function()
               if luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
               end
            end, { "i", "s" }),
         }),
         -- sources for autocompletion
         sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" }, -- snippets
            { name = "buffer" }, -- text within current buffer
            { name = "path" }, -- file system paths
            { name = "cmdline" },
            { name = "nvim_lua" },
            { name = "nvim_lsp_signature_help" },
         }),
         -- configure lspkind for vs-code like pictograms in completion menu
         formatting = {
            format = lspkind.cmp_format({
               maxwidth = 50,
               ellipsis_char = "...",
            }),
         },
      })
      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
         mapping = cmp.mapping.preset.cmdline(),
         sources = {
            { name = "buffer" },
         },
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
         mapping = cmp.mapping.preset.cmdline(),
         sources = cmp.config.sources({
            { name = "path" },
         }, {
            {
               name = "cmdline",
               option = {
                  ignore_cmds = { "Man", "!" },
               },
            },
         }),
      })
   end,
}
