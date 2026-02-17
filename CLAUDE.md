# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration built with Lua, using Lazy.nvim as the plugin manager. The configuration follows a modular structure where each feature area has its own configuration file.

### Core Structure

- `init.lua` - Main entry point that bootstraps Lazy.nvim and loads core configuration
- `lua/config/` - Core configuration modules (keymaps, options, lazy setup)
- `lua/plugins/` - Plugin definitions organized by functionality
- `lua/maps.lua` - Legacy keymaps and settings (being migrated)
- `lazy-lock.json` - Plugin version lock file managed by Lazy.nvim

### Key Configuration Modules

- `lua/config/lazy.lua` - Lazy.nvim bootstrap and setup
- `lua/config/keymaps.lua` - Modern keymap definitions
- `lua/config/options.lua` - Neovim options and settings
- `lua/plugins/` - Plugin definitions split by category:
  - `completion.lua` - nvim-cmp and completion setup
  - `lsp.lua` - Mason and LSP configuration
  - `telescope.lua` - Fuzzy finding configuration
  - `neo-tree.lua` - File explorer configuration
  - `colorscheme.lua` - Theme configuration
  - `ui.lua` - UI enhancements
  - `terminal.lua` - Terminal integration
  - `treesitter.lua` - Syntax highlighting

### Plugin Architecture

The configuration uses these core plugin categories:
- **Completion**: nvim-cmp with LSP, buffer, treesitter, and LuaSnip sources
- **LSP**: Mason for server management, nvim-lspconfig for server setup
- **Navigation**: Telescope for fuzzy finding, Neo-tree for file explorer
- **UI**: Lualine for statusline, Catppuccin theme, Bufferline for tabs
- **Development**: Git integration (gitsigns), terminal (toggleterm), Claude Code integration

## Key Features and Keybindings

- Leader key: `,` (comma)
- File finding: `<leader>ff` (Telescope find_files), `<leader>gf` (git files)
- Live grep: `<leader>fa`, Help tags: `<leader>fh`
- File browser: `<leader>b` (Neo-tree toggle), `<leader>e` (focus)
- Terminal: `<Ctrl-,>` to toggle, `<leader>tg` for lazygit
- Buffer navigation: `F2`/`F3` (previous/next), `<leader>x` (delete)
- LSP: `gd` (definition), `gr` (references), `K` (hover), `rn` (rename), `<leader>ca` (code action)
- Formatting: `<C-f>` (format buffer)

## Environment Setup

Create `lua/env.lua` with:
```lua
vim.env.OPENAI_API_KEY = your_key
```

## Common Development Commands

### Plugin Management
- `:Lazy` - Open Lazy.nvim UI for plugin management
- `:Lazy install` - Install plugins
- `:Lazy update` - Update plugins
- `:Lazy sync` - Clean and update plugins
- `:Lazy clean` - Remove unused plugins

### LSP and Mason
- `:Mason` - Open Mason UI for LSP server management
- `:LspInfo` - Show LSP client information
- `:LspRestart` - Restart LSP servers

### Treesitter
- `:TSUpdate` - Update Treesitter parsers
- `:TSInstall <language>` - Install specific language parser

## File Modification Guidelines

- Plugin additions go in appropriate files in `lua/plugins/`
- Keybindings go in `lua/config/keymaps.lua` (new) or `lua/maps.lua` (legacy)
- LSP server configurations go in `lua/plugins/lsp.lua`
- Completion settings go in `lua/plugins/completion.lua`
- New plugin categories should get their own file in `lua/plugins/`

## Language Support

Configured language servers via Mason:
- HTML, Svelte, TypeScript/JavaScript (ts_ls)
- Additional parsers available via Treesitter

The configuration includes specialized support for:
- Web development (Svelte, TypeScript, HTML, CSS)
- Game development (Godot via godot.nvim)
- General programming with LSP and completion
- AI assistance (ChatGPT and Claude Code integration)