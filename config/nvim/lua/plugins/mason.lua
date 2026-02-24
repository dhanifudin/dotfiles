return {
  -- Mason: LSP/DAP/Linter/Formatter installer
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        -- TypeScript/JavaScript
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        "eslint_d",
        "prettierd",

        -- Web Development
        "emmet-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",

        -- Debugging
        "js-debug-adapter",

        -- Lua
        "stylua",
        "lua-language-server",
      },
    },
  },
}
