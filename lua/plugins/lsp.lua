return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ruff",
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "gopls",
        },
      })

      -- Capabilities for autocompletion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP settings
      local lspconfig = require("lspconfig")

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      -- Python
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      })

      lspconfig.ruff.setup({
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities,
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })

      -- JSON
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      -- YAML
      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })

      -- Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
          },
        },
      })

      -- Global mappings
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", function()
            vim.lsp.buf.declaration({ reuse_win = true })
          end, opts)
          vim.keymap.set("n", "gd", function()
            local params = vim.lsp.util.make_position_params()
            vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
              if err then
                vim.notify("Error when finding definition: " .. tostring(err), vim.log.levels.ERROR)
                return
              end
              if not result or vim.tbl_isempty(result) then
                vim.notify("No definition found", vim.log.levels.INFO)
                return
              end
              -- Safer jump to location with error handling
              local client = vim.lsp.get_client_by_id(ctx.client_id)
              if client then
                vim.lsp.util.jump_to_location(result[1] or result, client.offset_encoding)
              end
            end)
          end, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
}