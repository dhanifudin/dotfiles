return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          current_line = true,
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false, -- handled by nvim-lsp-endhints
      },
    },
  },
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {
      icons = {
        type = "󰜁 ",
        parameter = "󰏪 ",
      },
    },
  },
}
