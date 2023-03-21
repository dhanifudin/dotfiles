return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  build = ":COQdeps",
  dependencies = {
    "ms-jpq/coq.artifacts",
  },
  config = function()
    local lspstatus, lspconfig = pcall(require, "lspconfig")

    if lspstatus then
      vim.g.coq_settings = {
        keymap = { pre_select = true },
      }
      local coqstatus, coq = pcall(require, "coq")
      if coqstatus then
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(_, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(
            bufnr,
            "omnifunc",
            "v:lua.vim.lsp.omnifunc"
          )

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          -- vim.keymap.set(bufnr, 'n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            bufopts
          )
          vim.keymap.set(
            "n",
            "<space>wr",
            vim.lsp.buf.remove_workspace_folder,
            bufopts
          )
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }

        local servers = {
          "cssls",
          "dockerls",
          "gopls",
          "grammarly",
          "html",
          "intelephense",
          "jsonls",
          "pyright",
          "tsserver",
          "yamlls",
          "fortls",
        }

        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end
      end
      vim.cmd([[:COQnow -s]])
    end
  end,
}