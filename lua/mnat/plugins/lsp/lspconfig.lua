return {
   "neovim/nvim-lspconfig",
   event = { "BufReadPre", "BufNewFile" },
   dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
      { "j-hui/fidget.nvim", opts = {} },
   },
   config = function()
      -- import lspconfig plugin
      ---@diagnostic disable-next-line: unused-local
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap.set -- for conciseness
      local opts = { noremap = true, silent = true }
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      keymap("n", "<space>e", vim.diagnostic.open_float, opts)
      keymap("n", "[d", vim.diagnostic.goto_prev, opts)
      keymap("n", "]d", vim.diagnostic.goto_next, opts)
      keymap("n", "<space>q", vim.diagnostic.setloclist, opts)

      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
         callback = function(event)
            -- NOTE: Remember that lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself
            -- many times.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local map = function(keys, func, desc)
               vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-T>.
            map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

            -- Find references for the word under your cursor.
            map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

            -- Fuzzy find all the symbols in your current workspace
            --  Similar to document symbols, except searches over your whole project.
            map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

            -- Rename the variable under your cursor
            --  Most Language Servers support renaming across files, etc.
            map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            -- Opens a popup that displays documentation about the word under your cursor
            --  See `:help K` for why this keymap
            map("K", vim.lsp.buf.hover, "Hover Documentation")

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header
            map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
               vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.server_capabilities.documentHighlightProvider then
               vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                  buffer = event.buf,
                  callback = vim.lsp.buf.document_highlight,
               })

               vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                  buffer = event.buf,
                  callback = vim.lsp.buf.clear_references,
               })
            end
         end,
      })
      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
         local hl = "DiagnosticSign" .. type
         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local servers = {
         pyright = {},
         rust_analyzer = {
            imports = {
               granularity = {
                  group = "module",
               },
               prefix = "self",
            },
            cargo = {
               buildScripts = {
                  enable = true,
               },
            },
            procMacro = {
               enable = true,
            },
            checkOnSave = {
               command = "clippy",
            },
            inlayHints = { enable = true },
         },
         lua_ls = {
            -- make the language server recognize "vim" global
            diagnostics = {
               globals = { "vim" },
            },
            workspace = {
               -- make language server aware of runtime files
               library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
               },
               checkThirdParty = false,
            },
            completion = {
               callSnippet = "Replace",
            },
            telemetry = { enable = false },
         },
         gopls = {
            analyses = {
               unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
         },
      }

      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
         "stylua", -- Used to format lua code
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
         handlers = {
            function(server_name)
               local server = servers[server_name] or {}
               -- This handles overriding only values explicitly passed
               -- by the server configuration above. Useful when disabling
               -- certain features of an LSP (for example, turning off formatting for tsserver)
               server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
               require("lspconfig")[server_name].setup(server)
            end,
         },
      })
   end,
}
