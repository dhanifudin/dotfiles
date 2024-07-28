return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_ls = {
          filetypes = {
            "blade",
            "css",
            "html",
            "htmldjango",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "vue",
          },
        },
      },
    },
  },
}
