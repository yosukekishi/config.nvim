return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA",
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({
        preset = "modern",
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        win = {
          border = "rounded",
          no_overlap = true,
          padding = { 2, 2 },
          wo = {
            winblend = 0,
          },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        keys = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        filter = function(mapping)
          return true
        end,
        spec = {},
        replace = {
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        triggers = {
          { "<auto>", mode = "nixsotc" },
          { "s", mode = { "n", "v" } },
        },
        defer = function(ctx)
          return ctx.mode == "v" or ctx.mode == "<C-V>"
        end,
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt" },
        },
      })
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require("auto-save").setup({
        enabled = true,
        trigger_events = {
          immediate_save = { "BufLeave", "FocusLost" },
          defer_save = { "InsertLeave", "TextChanged" },
          cancel_deferred_save = { "InsertEnter" },
        },
        condition = function(buf)
          local fn = vim.fn
          local utils = require("auto-save.utils.data")
          
          if
            fn.getbufvar(buf, "&modifiable") == 1 and
            utils.not_in(fn.getbufvar(buf, "&filetype"), {}) and
            utils.not_in(fn.bufname(buf), {}) and
            fn.getbufvar(buf, "&readonly") == 0
          then
            return true
          end
          return false
        end,
        write_all_buffers = false,
        debounce_delay = 1000,
        callbacks = {
          enabling = nil,
          disabling = nil,
          before_asserting_save = nil,
          before_saving = nil,
          after_saving = nil
        },
      })
      
      vim.keymap.set("n", "<leader>as", ":ASToggle<CR>", { desc = "Toggle autosave" })
    end,
  },
}