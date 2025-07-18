return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    version = false,
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("venv-selector").setup({
        settings = {
          options = {
            notify_user_on_venv_activation = true,
          },
          search = {
            my_venvs = {
              command = "find ~/.virtualenvs -maxdepth 1 -type d -name '*' | head -10",
            },
            workspace = {
              command = "find $PWD -maxdepth 2 -type d -name 'venv' -o -name '.venv' -o -name 'env' -o -name '.env' | head -10",
            },
          },
        },
      })
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      dapui.setup()
      
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      require("dap-python").setup("python")
      
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = function()
              return vim.fn.exepath("python")
            end,
          }),
        },
      })
      
      vim.keymap.set("n", "<leader>tt", function()
        require("neotest").run.run()
      end, { desc = "Run nearest test" })
      
      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "Run tests in file" })
      
      vim.keymap.set("n", "<leader>td", function()
        require("neotest").run.run({ strategy = "dap" })
      end, { desc = "Debug nearest test" })
      
      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").summary.toggle()
      end, { desc = "Toggle test summary" })
      
      vim.keymap.set("n", "<leader>to", function()
        require("neotest").output.open({ enter = true })
      end, { desc = "Open test output" })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "hkupty/iron.nvim",
    config = function()
      local iron = require("iron.core")
      
      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = {"python3"},
              format = require("iron.fts.common").bracketed_paste,
            },
          },
          repl_open_cmd = require("iron.view").right(50),
        },
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
      })
      
      vim.keymap.set("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "Open Python REPL" })
      vim.keymap.set("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "Restart REPL" })
      vim.keymap.set("n", "<leader>rf", "<cmd>IronFocus<cr>", { desc = "Focus REPL" })
      vim.keymap.set("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide REPL" })
    end,
  },
}