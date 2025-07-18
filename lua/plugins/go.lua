return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        go = "go",
        goimports = "gopls",
        fillstruct = "gopls",
        gofmt = "gofumpt",
        max_line_len = 120,
        tag_transform = false,
        tag_options = "json=omitempty",
        gotests_template = "",
        gotests_template_dir = "",
        comment_placeholder = "",
        icons = { breakpoint = "🧘", currentpos = "🏃" },
        verbose = false,
        lsp_cfg = false,
        lsp_gofumpt = true,
        lsp_on_attach = nil,
        lsp_keymaps = false,
        lsp_codelens = true,
        diagnostic = {
          hdlr = true,
          underline = true,
          virtual_text = { space = 0, prefix = "■" },
          signs = true,
          update_in_insert = false,
        },
        lsp_document_formatting = true,
        lsp_inlay_hints = {
          enable = true,
          style = "inlay",
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_variable_name = true,
          parameter_hints_prefix = "󰊕 ",
          show_parameter_hints = true,
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 6,
          highlight = "Comment",
        },
        gopls_cmd = nil,
        gopls_remote_auto = true,
        gocoverage_sign = "█",
        sign_priority = 5,
        dap_debug = true,
        dap_debug_keymap = true,
        dap_debug_gui = true,
        dap_debug_vt = true,
        dap_port = 38697,
        dap_timeout = 15,
        dap_retries = 20,
        build_tags = "tag1,tag2",
        textobjects = true,
        test_runner = "go",
        verbose_tests = false,
        run_in_floaterm = false,
        floaterm = {
          posititon = "auto",
          width = 0.45,
          height = 0.98,
          title_colors = "nord",
        },
        trouble = false,
        test_efm = false,
        luasnip = true,
        iferr_vertical_shift = 4,
      })
      
      -- Go specific keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          -- Run/Build
          vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<CR>", { buffer = true, desc = "Go Run" })
          vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<CR>", { buffer = true, desc = "Go Build" })
          
          -- Test
          vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", { buffer = true, desc = "Go Test" })
          vim.keymap.set("n", "<leader>gT", "<cmd>GoTestFunc<CR>", { buffer = true, desc = "Go Test Function" })
          vim.keymap.set("n", "<leader>gf", "<cmd>GoTestFile<CR>", { buffer = true, desc = "Go Test File" })
          vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<CR>", { buffer = true, desc = "Go Coverage" })
          
          -- Code generation
          vim.keymap.set("n", "<leader>ge", "<cmd>GoIfErr<CR>", { buffer = true, desc = "Go If Err" })
          vim.keymap.set("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", { buffer = true, desc = "Go Fill Struct" })
          vim.keymap.set("n", "<leader>gfp", "<cmd>GoFillPara<CR>", { buffer = true, desc = "Go Fill Parameters" })
          vim.keymap.set("n", "<leader>gat", "<cmd>GoAddTag<CR>", { buffer = true, desc = "Go Add Tags" })
          vim.keymap.set("n", "<leader>grt", "<cmd>GoRmTag<CR>", { buffer = true, desc = "Go Remove Tags" })
          vim.keymap.set("n", "<leader>gmt", "<cmd>GoModTidy<CR>", { buffer = true, desc = "Go Mod Tidy" })
          
          -- Debugging
          vim.keymap.set("n", "<leader>gdb", "<cmd>GoDebug<CR>", { buffer = true, desc = "Go Debug" })
          vim.keymap.set("n", "<leader>gds", "<cmd>GoDebug -s<CR>", { buffer = true, desc = "Go Debug Stop" })
          vim.keymap.set("n", "<leader>gdt", "<cmd>GoDebug -t<CR>", { buffer = true, desc = "Go Debug Test" })
          
          -- Implementation
          vim.keymap.set("n", "<leader>gi", "<cmd>GoImpl<CR>", { buffer = true, desc = "Go Implement Interface" })
          
          -- Documentation
          vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<CR>", { buffer = true, desc = "Go Doc" })
        end,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          }),
        },
      })
    end,
  },
}