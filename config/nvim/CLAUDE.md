# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim configuration for Neovim, customized for React and Node.js development with TypeScript/JavaScript ES6 support. It uses lazy.nvim as the plugin manager and follows LazyVim's standard configuration structure. 46 LazyVim extras are enabled via `lazyvim.json`.

## Configuration Architecture

### Plugin System

Plugins are defined in individual files under `lua/plugins/`. Each plugin file should:

- Return a Lua table with plugin specifications
- Follow LazyVim's plugin structure
- Use lazy-loading where appropriate (`event`, `ft`, `keys`, `cmd`)
- Avoid duplicating LazyVim's built-in configurations

**Key principle**: LazyVim already includes many standard plugins (LSP, Treesitter, Mason, DAP, etc.). Only add configurations that extend or customize beyond LazyVim's defaults. Import LazyVim extras using `{ import = "lazyvim.plugins.extras.xxx" }`.

### Core Configuration Files

- `init.lua` - Entry point that bootstraps LazyVim via `require("config.lazy")`
- `lua/config/lazy.lua` - Lazy.nvim bootstrap and plugin specifications
- `lua/config/options.lua` - Neovim options (uses LazyVim defaults)
- `lua/config/keymaps.lua` - Custom keybindings (uses LazyVim defaults)
- `lua/config/autocmds.lua` - Autocommands: theme switcher + diff focus
- `lua/config/runner.lua` - Terminal command runner (Dispatch, Npm, Composer)

### Current Customizations

**Theme**: Catppuccin with automatic light/dark switching

- Light mode (Latte): 7 AM - 6 PM
- Dark mode (Mocha): 6 PM - 7 AM
- Auto-checks every hour via timer in `autocmds.lua`
- Diff focus: auto-closes non-diff windows when entering diff mode, preserving floating windows and AI panels (ClaudeCode, OpenCode)

**Development Stack**:

- TypeScript/JavaScript ES6 via LazyVim extras
- React with auto-tag support (nvim-ts-autotag)
- Node.js package.json management (package-info.nvim)
- Emmet support for HTML/CSS/JSX/TSX
- PHP via Composer runner

**UI**:

- Dashboard with hyper theme: week header, shortcut buttons, recent projects, recent files, plugin stats
- Neo-tree positioned on right, width 25 columns
- Tmux integration for seamless pane navigation (Ctrl+hjkl)
- Markdown rendering via render-markdown.nvim

**Tools**:

- AI integration: OpenCode (`<leader>ao`) and ClaudeCode terminal drawer
- WakaTime time tracking
- Variable segment text objects for camelCase/snake_case navigation

### Keybinding Conventions

Follow LazyVim's standard leader key conventions:

- `<leader>c` prefix: Code actions
- `<leader>a` prefix: AI/application integrations
- `<leader>r` prefix: Runner/terminal commands
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
- `<leader>cpc` - Hide package info
- `<leader>cpu` - Update package
- `<leader>cpi` - Install package
- `<leader>cpd` - Delete package
- `<leader>cpr` - Reinstall dependencies
- `<leader>cpp` - Change package version

LazyVim provides TypeScript LSP, ESLint, Prettier, and DAP debugging out of the box.

### Terminal Runner

Defined in `lua/config/runner.lua`. Provides terminal execution with toggleable bottom drawer.

**Commands:**

- `:Dispatch <cmd>` - Run arbitrary shell command in bottom terminal
- `:DispatchFocus <cmd>` - Run command with focus on terminal
- `:DispatchToggle` - Toggle terminal visibility
- `:Npm <args>` - Run npm commands from project root (with completions)
- `:Composer <args>` - Run composer commands from project root (with completions)

**Keybindings:**

- `<leader>rd` - Dispatch prompt
- `<leader>rf` - Dispatch with focus
- `<leader>rt` - Toggle dispatch terminal
- `<leader>rn` - Npm prompt
- `<leader>rni` - npm install
- `<leader>rns` - npm start
- `<leader>rnt` - npm test
- `<leader>rnb` - npm build
- `<leader>rnd` - npm run dev
- `<leader>rnl` - npm run lint
- `<leader>rc` - Composer prompt
- `<leader>rci` - composer install
- `<leader>rcu` - composer update
- `<leader>rct` - composer test
- `<leader>rcd` - composer dump-autoload

### Dashboard

Defined in `lua/plugins/dashboard.lua`. Uses dashboard-nvim's `hyper` theme.

- **Week header** — shows current day and date
- **Shortcuts**: `f` Find File, `g` Grep Text, `p` Projects, `s` Restore Session, `c` Config, `l` Lazy, `q` Quit
- **Project list** — 8 recent projects from project.nvim history (press entry to `Telescope find_files` in that dir)
- **MRU** — 10 most-recently-used files (global, not cwd-only)
- **Footer** — lazy.nvim plugin load stats and startup time

### Project Detection

Defined in `lua/plugins/project.lua`. Extends LazyVim's `util.project` extra with broader patterns:

Detection patterns: `.git`, `package.json`, `composer.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `setup.py`, `Makefile`, `.terraform`, `docker-compose.yml`, `docker-compose.yaml`

- `<leader>fp` - Find Projects (Telescope projects picker)

### Session Management

Defined in `lua/plugins/project.lua` via `folke/persistence.nvim`. Sessions auto-save per directory on `BufReadPre`.

- `<leader>qs` - Restore session for current directory
- `<leader>qS` - Select from available sessions
- `<leader>ql` - Restore last session (across all directories)
- `<leader>qd` - Stop saving session for current session

### Emmet Support

Defined in `lua/plugins/emmet.lua`. Supports HTML/CSS/JSX/TSX expansion.

- `<leader>ce` - Wrap with emmet abbreviation
- Supported filetypes: html, css, scss, javascript, javascriptreact, typescript, typescriptreact, vue, svelte

### Variable Segment Text Objects

Defined in `lua/plugins/variable-segment.lua` + `lua/util/variable_segment.lua`. Handles camelCase, PascalCase, snake_case, SCREAMING_SNAKE, and mixed conventions.

- `iv` - Inner variable segment (visual/operator-pending)
- `av` - Around variable segment (including separator)

### Tmux Integration

Navigation between Neovim splits and tmux panes:

- `<C-h/j/k/l>` - Move between panes/splits seamlessly
- Clipboard syncing enabled between Neovim and tmux
- Cycle navigation enabled (wraps at edges)

## Development Workflow

1. **Adding a new plugin**: Create a new file in `lua/plugins/` that returns a table with plugin specs
2. **Customizing existing plugins**: Override LazyVim defaults by creating a file with the same plugin name
3. **Testing changes**: Restart Neovim or use `:Lazy reload` for the specific plugin
4. **LazyVim extras**: Check [LazyVim docs](https://lazyvim.github.io/extras) before adding plugins manually; extras are tracked in `lazyvim.json`

## File Organization

```
~/.config/nvim/
├── init.lua                        # Entry point
├── lazyvim.json                    # LazyVim extras configuration (46 extras)
├── lazy-lock.json                  # Plugin version lock file
├── stylua.toml                     # Lua formatter config
├── .neoconf.json                   # Neoconf/LSP configuration
├── lua/
│   ├── config/                     # Core configuration
│   │   ├── lazy.lua               # Plugin manager bootstrap and setup
│   │   ├── options.lua            # Neovim options (LazyVim defaults)
│   │   ├── keymaps.lua            # Custom keybindings (LazyVim defaults)
│   │   ├── autocmds.lua           # Autocommands (theme switcher, diff focus)
│   │   └── runner.lua             # Terminal runner (Dispatch, Npm, Composer)
│   ├── plugins/                    # Plugin specifications
│   │   ├── ai.lua                 # OpenCode + ClaudeCode AI integration
│   │   ├── catppuccin.lua         # Theme with auto light/dark switching
│   │   ├── dashboard.lua          # Dashboard hyper theme (week header, shortcuts, projects, MRU)
│   │   ├── emmet.lua              # Emmet for HTML/CSS/JSX/TSX
│   │   ├── lsp.lua                # LSP diagnostics styling
│   │   ├── markdown.lua           # Markdown rendering
│   │   ├── mason.lua              # Tool installer (LSP, DAP, linters, formatters)
│   │   ├── neo-tree.lua           # File explorer (right side, width 25)
│   │   ├── project.lua            # Project detection patterns + persistence.nvim sessions
│   │   ├── react.lua              # React support (auto-tag, package-info)
│   │   ├── tmux.lua               # Tmux pane navigation
│   │   ├── typescript.lua         # TS/JS LazyVim extras
│   │   ├── variable-segment.lua   # Variable segment text object plugin
│   │   └── wakatime.lua           # WakaTime time tracking
│   └── util/                       # Utility modules
│       └── variable_segment.lua   # Variable segment implementation
```

### Mason-installed Tools

- **TypeScript/JS**: typescript-language-server, eslint-lsp, prettier, eslint_d, prettierd
- **Web**: emmet-language-server, html-lsp, css-lsp, tailwindcss-language-server
- **Debugging**: js-debug-adapter
- **Lua**: stylua, lua-language-server
