return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local installed, treesitter = pcall(require, "nvim-treesitter.configs")

      if installed then
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false

        treesitter.setup({
          ensure_installed = {
            "bash",
            "c",
            "cpp",
            "dockerfile",
            "go",
            "gomod",
            "fortran",
            "haskell",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "jsonc",
            "lua",
            "php",
            "python",
            "yaml",
          },
          auto_install = true,
          highlight = {
            enable = true,
          },
        })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      local installed, treesitter = pcall(require, "nvim-treesitter.configs")

      if installed then
        treesitter.setup({
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.outer",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["av"] = { query = "@variable", query_group = "highlights" },
                ["iv"] = { query = "@variable", query_group = "highlights" },
              },
            },
          },
        })
      end
    end,
  },
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({})
    end,
  },
}