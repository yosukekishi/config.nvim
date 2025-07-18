# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using lazy.nvim as the plugin manager. The configuration is modular with plugins organized in separate files under `lua/plugins/`.

## Architecture

### Core Structure
- `init.lua`: Main configuration file with basic Neovim settings, keymaps, and autocommands
- `lua/lazy-setup.lua`: Lazy.nvim bootstrap and setup
- `lua/plugins/`: Plugin configurations organized by functionality

### Plugin Organization
- `lsp.lua`: Language Server Protocol setup with Mason, LSP servers for Lua, Python, TypeScript, HTML, CSS, JSON, YAML
- `completion.lua`: nvim-cmp autocompletion with LSP, snippets, buffer, and path sources
- `telescope.lua`: Fuzzy finder with fzf-native extension
- `file-explorer.lua`: Neo-tree file explorer configuration
- `git.lua`: Git integration (gitsigns, lazygit, diffview, blame, advanced search)
- `python.lua`: Python-specific tooling (venv-selector)
- `statusline.lua`: Lualine status line
- `colorscheme.lua`: Catppuccin color scheme
- `productivity.lua`: Productivity plugins (autopairs, comments, surround, which-key, autosave)
- `treesitter.lua`: Syntax highlighting
- `icons.lua`: Icon support

## Key Mappings

### Leader Key
- Leader key is space (`<space>`)

### File Operations
- `<leader>w`: Save file
- `<leader>q`: Quit
- `<leader>h`: Clear search highlight

### Navigation
- `<C-h/j/k/l>`: Window navigation
- `<leader>bn/bp/bd`: Buffer next/previous/delete
- `<leader>tn/tc/tm`: Tab new/close/move

### Telescope (Fuzzy Finding)
- `<leader>ff`: Find files
- `<leader>fg`: Live grep
- `<leader>fb`: Find buffers
- `<leader>fh`: Find help
- `<leader>fr`: Recent files
- `<leader>fc`: Find string under cursor

### File Explorer
- `<leader>e`: Toggle Neo-tree
- `<leader>o`: Focus Neo-tree

### Git (Gitsigns)
- `]c/[c`: Next/previous git hunk
- `<leader>hs/hr`: Stage/reset hunk
- `<leader>hS/hR`: Stage/reset buffer
- `<leader>hp`: Preview hunk
- `<leader>hb`: Blame line
- `<leader>hd`: Diff this

### Git History & Tools
- `<leader>gg`: Open LazyGit (full git interface)
- `<leader>gb`: Toggle Git Blame view
- `<leader>gd`: Open Diffview (diff current changes)
- `<leader>gc`: Close Diffview
- `<leader>gh`: File History (all files)
- `<leader>gH`: Current File History
- `<leader>gs`: Advanced Git Search

### Python Development
- `<leader>vs`: Select virtual environment
- `<leader>vc`: Select cached virtual environment

### Python Debugging (nvim-dap)
- `<leader>db`: Toggle breakpoint
- `<leader>dc`: Continue debugging
- `<leader>ds`: Step over
- `<leader>di`: Step into
- `<leader>do`: Step out
- `<leader>dr`: Open debug REPL
- `<leader>dt`: Toggle DAP UI

### Python Testing (neotest)
- `<leader>tt`: Run nearest test
- `<leader>tf`: Run tests in file
- `<leader>td`: Debug nearest test
- `<leader>ts`: Toggle test summary
- `<leader>to`: Open test output

### Python Formatting
- `<leader>cf`: Format buffer (black + isort)

### Python REPL (iron.nvim)
- `<leader>rs`: Open Python REPL
- `<leader>rr`: Restart REPL
- `<leader>rf`: Focus REPL
- `<leader>rh`: Hide REPL
- `<space>sc`: Send code to REPL
- `<space>sl`: Send line to REPL
- `<space>sf`: Send file to REPL

### AutoSave
- `<leader>as`: Toggle autosave on/off

### LSP (when attached)
- `gd`: Go to definition
- `gD`: Go to declaration
- `gr`: Go to references
- `gi`: Go to implementation
- `K`: Hover documentation
- `<space>rn`: Rename symbol
- `<space>ca`: Code actions
- `<space>f`: Format document
- `<leader>d`: Show diagnostics
- `[d/]d`: Previous/next diagnostic

## Development Workflow

### Adding New Plugins
1. Create a new file in `lua/plugins/` or add to existing category file
2. Follow the existing pattern: return table with plugin specifications
3. Include proper configuration in the `config` function
4. Add necessary keymaps within the plugin configuration

### LSP Configuration
- LSP servers are managed through Mason
- Add new servers to the `ensure_installed` list in `lsp.lua`
- Configure server-specific settings in the respective `lspconfig.server.setup()` call

### File Type Specific Settings
- Python files use 4-space indentation
- Lua, JavaScript, TypeScript, JSON, YAML, HTML, CSS use 2-space indentation
- Configured via autocommands in `init.lua`

## Plugin Management

### Lazy.nvim Commands
- `:Lazy`: Open lazy.nvim dashboard
- `:Lazy sync`: Update and install plugins
- `:Lazy clean`: Remove unused plugins
- `:Lazy profile`: Profile plugin loading times

### Mason Commands
- `:Mason`: Open Mason dashboard
- `:MasonUpdate`: Update Mason registry
- `:MasonInstall <server>`: Install LSP server
- `:MasonUninstall <server>`: Uninstall LSP server

## Important Notes

### Python Development
- Virtual environment selection available through venv-selector
- Supports both workspace-local environments (venv, .venv, env, .env) and global environments in ~/.virtualenvs
- Pyright and Ruff are configured for Python development

#### Enhanced Python Features
- **Debugging**: nvim-dap with debugpy for Python debugging, UI integration with dap-ui
- **Testing**: neotest with pytest runner, supports running and debugging individual tests
- **Formatting**: conform.nvim with black and isort for automatic code formatting
- **REPL**: iron.nvim for interactive Python development with code sending capabilities
- **Code Quality**: Integration with existing Ruff and Pyright LSP setup

### Git Integration
- **Gitsigns**: Git status in sign column, hunk operations, blame functionality
- **LazyGit**: Full-featured git interface with `<leader>gg`
- **Diffview**: Visual diff and merge tool with conflict resolution
- **Blame**: Enhanced git blame view with `<leader>gb`
- **Advanced Git Search**: Telescope-based git history search with `<leader>gs`
- **File History**: View git history for files with `<leader>gh` and `<leader>gH`
- Git status integration in Neo-tree file explorer

### Performance Optimizations
- Several default Neovim plugins are disabled for better performance
- Lazy loading configured for appropriate plugins
- Treesitter and completion are optimized for performance

### AutoSave Feature
- Automatic file saving on text changes and focus loss
- Debounced saving (1 second delay) to prevent excessive writes
- Visual feedback with timestamp when files are saved
- Can be toggled on/off with `<leader>as`
- Only saves modifiable, non-readonly files