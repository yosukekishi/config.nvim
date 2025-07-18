return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = require("telescope.actions").cycle_history_next,
              ["<C-p>"] = require("telescope.actions").cycle_history_prev,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "ivy",
          },
        },
      })

      require("telescope").load_extension("fzf")

      -- Key mappings
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Find Help" })
      vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "Recent Files" })
      vim.keymap.set("n", "<leader>fc", require("telescope.builtin").grep_string, { desc = "Find String" })
    end,
  },
}