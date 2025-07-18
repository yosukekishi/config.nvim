return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    config = function()
      -- Markdown Preview settings
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_port = ''
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_theme = 'dark'

      -- Keymaps
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
      vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop Markdown Preview" })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        heading = {
          enabled = true,
          sign = true,
          icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
        },
        code = {
          enabled = true,
          sign = true,
          style = "full",
          position = "left",
          language_pad = 0,
          disable_background = { "diff" },
          width = "full",
          left_margin = 0,
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
          border = "thin",
          above = "▄",
          below = "▀",
          highlight = "RenderMarkdownCode",
          highlight_inline = "RenderMarkdownCodeInline",
        },
        dash = {
          enabled = true,
          icon = "─",
          width = "full",
          highlight = "RenderMarkdownDash",
        },
        bullet = {
          enabled = true,
          icons = { "●", "○", "◆", "◇" },
          left_pad = 0,
          right_pad = 0,
          highlight = "RenderMarkdownBullet",
        },
        checkbox = {
          enabled = true,
          unchecked = {
            icon = "󰄱 ",
            highlight = "RenderMarkdownUnchecked",
          },
          checked = {
            icon = "󰱒 ",
            highlight = "RenderMarkdownChecked",
          },
          custom = {
            todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
          },
        },
        quote = {
          enabled = true,
          icon = "▌",
          repeat_linebreak = false,
          highlight = "RenderMarkdownQuote",
        },
        pipe_table = {
          enabled = true,
          preset = "none",
          style = "full",
          cell = "padded",
          alignment_indicator = "━",
          border = {
            "┌", "┬", "┐",
            "├", "┼", "┤",
            "└", "┴", "┘",
            "│", "─",
          },
          head = "RenderMarkdownTableHead",
          row = "RenderMarkdownTableRow",
          filler = "RenderMarkdownTableFill",
        },
        link = {
          enabled = true,
          image = "󰥶 ",
          email = "󰊫 ",
          hyperlink = "󰌹 ",
          highlight = "RenderMarkdownLink",
          custom = {
            web = { pattern = "^http[s]?://", icon = "󰖟 " },
          },
        },
        sign = {
          enabled = true,
          highlight = "RenderMarkdownSign",
        },
        indent = {
          enabled = false,
        },
        win_options = {
          conceallevel = {
            default = vim.api.nvim_get_option_value("conceallevel", {}),
            rendered = 3,
          },
          concealcursor = {
            default = vim.api.nvim_get_option_value("concealcursor", {}),
            rendered = "",
          },
        },
      })
    end,
  },
}