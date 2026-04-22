-- VSCode Neovim extension integration.
-- These specs only activate when running inside VSCode (vim.g.vscode = true).
-- Disable UI plugins that VSCode already provides; delegate navigation to VSCode APIs.

if not vim.g.vscode then
  return {}
end

local vsc = function(cmd)
  return function() require("vscode").call(cmd) end
end

return {
  -- Disable plugins that conflict with or are redundant in VSCode
  { "nvim-mini/mini.statusline", enabled = false },
  { "nvim-mini/mini.icons",      enabled = false },
  { "folke/which-key.nvim",      enabled = false },
  { "lewis6991/gitsigns.nvim",   enabled = false },
  { "folke/snacks.nvim",         enabled = false },
  { "catppuccin/nvim",           enabled = false },
  { "stevearc/oil.nvim",         enabled = false },
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "stevearc/conform.nvim",     enabled = false },
  { "mfussenegger/nvim-lint",    enabled = false },

  -- vscode-neovim bridge plugin
  {
    "vscode-neovim/vscode-ext.nvim",
    lazy = false,
    cond = vim.g.vscode ~= nil,
  },

  -- VSCode-specific keymaps (override the standard ones)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    init = function()
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
      end

      -- File navigation
      map("n", "<leader><leader>", vsc("workbench.action.quickOpen"),            "Quick open file")
      map("n", "<leader>ff",       vsc("workbench.action.quickOpen"),            "Find files")
      map("n", "<leader>fg",       vsc("workbench.action.findInFiles"),          "Find in files")
      map("n", "<leader>/",        vsc("workbench.action.findInFiles"),          "Find in files")
      map("n", "<leader>fb",       vsc("workbench.action.showAllEditors"),       "Show all editors")
      map("n", "<leader>fr",       vsc("workbench.action.openRecent"),           "Recent files")

      -- LSP-style navigation (delegated to VSCode)
      map("n", "gd",  vsc("editor.action.revealDefinition"),       "Go to definition")
      map("n", "gr",  vsc("editor.action.goToReferences"),         "References")
      map("n", "gI",  vsc("editor.action.goToImplementation"),     "Go to implementation")
      map("n", "gy",  vsc("editor.action.goToTypeDefinition"),     "Type definition")
      map("n", "gD",  vsc("editor.action.revealDeclaration"),      "Go to declaration")
      map("n", "K",   vsc("editor.action.showHover"),              "Hover")

      -- Code actions
      map("n", "<leader>ca", vsc("editor.action.quickFix"),        "Code action")
      map("v", "<leader>ca", vsc("editor.action.quickFix"),        "Code action")
      map("n", "<leader>cr", vsc("editor.action.rename"),          "Rename symbol")
      map("n", "<leader>cf", vsc("editor.action.formatDocument"),  "Format document")
      map("v", "<leader>cf", vsc("editor.action.formatSelection"), "Format selection")

      -- Diagnostics
      map("n", "[d", vsc("editor.action.marker.prev"),             "Prev diagnostic")
      map("n", "]d", vsc("editor.action.marker.next"),             "Next diagnostic")
      map("n", "<leader>cd", vsc("editor.action.showHover"),       "Diagnostic float")

      -- Explorer / sidebar
      map("n", "<leader>e", vsc("workbench.view.explorer"),        "File explorer")

      -- Git
      map("n", "<leader>gg", vsc("lazygit.openLazygit"),           "Lazygit")
      map("n", "]h", vsc("workbench.action.editor.nextChange"),    "Next git change")
      map("n", "[h", vsc("workbench.action.editor.prevChange"),    "Prev git change")

      -- Splits / windows (VSCode native)
      map("n", "<leader>wv", vsc("workbench.action.splitEditor"),                  "Split vertical")
      map("n", "<leader>wh", vsc("workbench.action.splitEditorDown"),              "Split horizontal")
      map("n", "<C-h>",      vsc("workbench.action.focusLeftGroup"),               "Focus left")
      map("n", "<C-l>",      vsc("workbench.action.focusRightGroup"),              "Focus right")
      map("n", "<C-k>",      vsc("workbench.action.focusAboveGroup"),              "Focus above")
      map("n", "<C-j>",      vsc("workbench.action.focusBelowGroup"),              "Focus below")

      -- Symbols
      map("n", "<leader>fs", vsc("workbench.action.gotoSymbol"),   "Document symbols")
      map("n", "<leader>fS", vsc("workbench.action.showAllSymbols"), "Workspace symbols")
    end,
  },
}
