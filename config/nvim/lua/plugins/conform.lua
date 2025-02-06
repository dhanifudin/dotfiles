return {
  "stevearc/conform.nvim",
  opts = function()
    local opts = {
      formatters = {
        kulala = {
          command = "kulala-fmt",
          args = { "$FILENAME" },
          stdin = false,
        },
      },
      formatters_by_ft = {
        blade = { "blade-formatter" },
        cs = { "csharpier" },
        html = { "prettierd" },
        http = { "kulala" },
        java = { "google-java-format" },
        javascript = { "prettierd" },
        lua = { "stylua" },
        php = { "pint" },
        sh = { "shfmt" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        xml = { "xmlformatter" },
      },
    }
    return opts
  end,
}
