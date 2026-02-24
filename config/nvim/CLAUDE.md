# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim configuration for Neovim, customized for React and Node.js development with TypeScript/JavaScript ES6 support. It uses lazy.nvim as the plugin manager and follows LazyVim's standard configuration structure.

## Configuration Architecture

### Plugin System

Plugins are defined in individual files under `lua/plugins/`. Each plugin file should:

- Return a Lua table with plugin specifications
- Follow LazyVim's plugin structure (see example.lua)
- Use lazy-loading where appropriate (`event`, `ft`, `keys`, `cmd`)
- Avoid duplicating LazyVim's built-in configurations

**Key principle**: LazyVim already includes many standard plugins (LSP, Treesitter, Mason, DAP, etc.). Only add configurations that extend or customize beyond LazyVim's defaults. Import LazyVim extras using `{ import = "lazyvim.plugins.extras.xxx" }`.

### Core Configuration Files

- `init.lua` - Entry point that bootstraps LazyVim via `require("config.lazy")`
- `lua/config/lazy.lua` - Lazy.nvim setup and plugin specifications
- `lua/config/options.lua` - Neovim options (extends LazyVim defaults)
- `lua/config/keymaps.lua` - Custom keybindings (extends LazyVim defaults)
- `lua/config/autocmds.lua` - Autocommands (extends LazyVim defaults)

### Current Customizations

**Theme**: Catppuccin with automatic light/dark switching

- Light mode (Latte): 7 AM - 6 PM
- Dark mode (Mocha): 6 PM - 7 AM
- Auto-checks every hour via timer in `autocmds.lua`

**Development Stack**:

- TypeScript/JavaScript ES6 via LazyVim extras
- React with auto-tag support (nvim-ts-autotag)
- Node.js package.json management (package-info.nvim)

**UI**:

- Neo-tree positioned on right, width 30 columns
- Tmux integration for seamless pane navigation (Ctrl+hjkl)

**Tools**:

- VS Code integration via opencode.nvim (`<leader>ao`)

### Keybinding Conventions

Follow LazyVim's standard leader key conventions:

- `<leader>c` prefix: Code actions
- `<leader>a` prefix: Application/tool integrations
- Use `keys` table in plugin specs for lazy-loaded keybindings
- Always include `desc` for which-key integration

Example:

```lua
keys = {
  { "<leader>ao", "<cmd>OpenCode<cr>", desc = "Open Code" },
}
```

### Package Management Commands

- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy reload <plugin>` - Reload a specific plugin
- `:Mason` - Open LSP/DAP/linter installer UI

### React/Node.js Development

Package.json management keybindings (in json files):

- `<leader>cps` - Show package info
- `<leader>cpu` - Update package
- `<leader>cpi` - Install package
- `<leader>cpd` - Delete package
- `<leader>cpr` - Reinstall dependencies
- `<leader>cpp` - Change package version

LazyVim provides TypeScript LSP, ESLint, Prettier, and DAP debugging out of the box.

### Tmux Integration

Navigation between Neovim splits and tmux panes:

- `<C-h/j/k/l>` - Move between panes/splits seamlessly
- Clipboard syncing enabled between Neovim and tmux

## Development Workflow

1. **Adding a new plugin**: Create a new file in `lua/plugins/` that returns a table with plugin specs
2. **Customizing existing plugins**: Override LazyVim defaults by creating a file with the same plugin name
3. **Testing changes**: Restart Neovim or use `:Lazy reload` for the specific plugin
4. **LazyVim extras**: Check [LazyVim docs](https://lazyvim.github.io/extras) before adding plugins manually

## File Organization

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/                 # Core configuration
│   │   ├── lazy.lua           # Plugin manager setup
│   │   ├── options.lua        # Neovim options
│   │   ├── keymaps.lua        # Custom keybindings
│   │   └── autocmds.lua       # Autocommands (includes theme switcher)
│   └── plugins/               # Plugin specifications
│       ├── catppuccin.lua     # Theme with auto light/dark
│       ├── typescript.lua     # TS/JS LazyVim extras
│       ├── react.lua          # React-specific plugins
│       ├── neo-tree.lua       # File explorer customization
│       ├── tmux.lua           # Tmux navigation
│       └── opencode.lua       # VS Code integration
└── lazy-lock.json             # Plugin version lock file
```
