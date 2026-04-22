return {
  -- LSP client config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Diagnostics
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
          end

          map("n", "gd",         vim.lsp.buf.definition,    "Go to definition")
          map("n", "gr",         vim.lsp.buf.references,    "References")
          map("n", "gI",         vim.lsp.buf.implementation,"Go to implementation")
          map("n", "gy",         vim.lsp.buf.type_definition,"Type definition")
          map("n", "gD",         vim.lsp.buf.declaration,   "Go to declaration")
          map("n", "K",          vim.lsp.buf.hover,         "Hover")
          map("n", "gK",         vim.lsp.buf.signature_help,"Signature help")
          map("i", "<C-k>",      vim.lsp.buf.signature_help,"Signature help")
          map("n", "<leader>ca", vim.lsp.buf.code_action,   "Code action")
          map("v", "<leader>ca", vim.lsp.buf.code_action,   "Code action")
          map("n", "<leader>cr", vim.lsp.buf.rename,        "Rename symbol")
        end,
      })

      -- Global capabilities (picked up by all servers via vim.lsp.config)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end
      vim.lsp.config("*", { capabilities = capabilities })

      -- Per-server overrides
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.config("volar", {
        filetypes = { "vue" },
        init_options = {
          vue = { hybridMode = false },
        },
      })

      vim.lsp.config("ts_ls", {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      })

      vim.lsp.config("emmet_language_server", {
        filetypes = {
          "html", "css", "scss",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "vue",
        },
        init_options = {
          -- Enable emmet completions and show them on trigger characters
          showSuggestionsAsSnippets = true,
        },
      })
    end,
  },

  -- Mason installer
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  -- Mason ↔ lspconfig bridge (v2 API: automatic_enable replaces setup_handlers)
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "ts_ls",
        "intelephense",
        "gopls",
        "rust_analyzer",
        "yamlls",
        "lua_ls",
        "tailwindcss",
        "html",
        "cssls",
        "emmet_language_server",
      },
      automatic_enable = true,
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true }) end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        typescript      = { "prettier" },
        javascript      = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        vue             = { "prettier" },
        html            = { "prettier" },
        css             = { "prettier" },
        scss            = { "prettier" },
        json            = { "prettier" },
        yaml            = { "prettier" },
        markdown        = { "prettier" },
        go              = { "goimports", "gofumpt" },
        rust            = { "rustfmt" },
        lua             = { "stylua" },
        php             = { "php_cs_fixer" },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        typescript      = { "eslint_d" },
        javascript      = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        vue             = { "eslint_d" },
      }

      if vim.fn.executable("golangci-lint") == 1 then
        lint.linters_by_ft.go = { "golangcilint" }
      end

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
