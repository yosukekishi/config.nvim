return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "yaml",
          "toml",
          "markdown",
          "bash",
          "vim",
          "dockerfile",
          "sql",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "python" },
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
          },
        },
        -- Python specific settings
        python = {
          highlight = {
            enable = true,
          },
        },
      })

      -- Force treesitter for Python files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.treesitter.start()
          vim.bo.syntax = "on"
        end,
      })

      -- Manual command to fix highlighting
      vim.api.nvim_create_user_command("TreesitterReload", function()
        vim.cmd("write")
        vim.cmd("edit")
        local buf = vim.api.nvim_get_current_buf()
        if vim.treesitter.highlighter.active[buf] then
          vim.treesitter.stop(buf)
        end
        if vim.bo.filetype and vim.bo.filetype ~= "" then
          vim.treesitter.start(buf)
        end
      end, {})
    end,
  },
}