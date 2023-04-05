return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  build = ":COQdeps",
  dependencies = {
    "neovim/nvim-lspconfig",
    "ms-jpq/coq.artifacts",
    "windwp/nvim-autopairs",
    "windwp/nvim-ts-autotag",
  },
  init = function()
    vim.g.coq_settings = {
      keymap = {
        -- recommended = false,
        pre_select = true,
        jump_to_mark = "<nop>",
      },
    }
  end,
  config = function()
    local lspstatus, lspconfig = pcall(require, "lspconfig")

    if lspstatus then
      local coqstatus, coq = pcall(require, "coq")
      local autopairs = require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
        map_bs = false,
      })
      require("nvim-ts-autotag").setup()
      if coqstatus then
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(_, bufnr)
          -- local remap = vim.api.nvim_set_keymap
          -- these mappings are coq recommended mappings unrelated to nvim-autopairs
          -- remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
          -- remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
          -- remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
          -- remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
          --
          -- -- skip it, if you use another global object
          -- _G.MUtils = {}
          --
          -- MUtils.CR = function()
          --   if vim.fn.pumvisible() ~= 0 then
          --     if vim.fn.complete_info({ "selected" }).selected ~= -1 then
          --       return autopairs.esc("<c-y>")
          --     else
          --       return autopairs.esc("<c-e>") .. autopairs.autopairs_cr()
          --     end
          --   else
          --     return autopairs.autopairs_cr()
          --   end
          -- end
          -- remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })
          --
          -- MUtils.BS = function()
          --   if
          --     vim.fn.pumvisible() ~= 0
          --     and vim.fn.complete_info({ "mode" }).mode == "eval"
          --   then
          --     return autopairs.esc("<c-e>") .. autopairs.autopairs_bs()
          --   else
          --     return autopairs.autopairs_bs()
          --   end
          -- end
          -- remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })

          -- -- Enable completion triggered by <c-x><c-o>
          -- vim.api.nvim_buf_set_option(
          --   bufnr,
          --   "omnifunc",
          --   "v:lua.vim.lsp.omnifunc"
          -- )

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          -- vim.keymap.set(bufnr, 'n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
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
          "ccls",
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