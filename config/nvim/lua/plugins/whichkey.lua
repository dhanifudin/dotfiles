return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>g",  group = "git" },
        { "<leader>gh", group = "git hunks" },
        { "<leader>c", group = "code" },
        { "<leader>a", group = "ai" },
        { "<leader>b", group = "buffer" },
        { "<leader>r", group = "runner" },
        { "<leader>rn", group = "npm" },
        { "<leader>rc", group = "composer" },
        { "<leader>q", group = "quit" },
        { "<leader>m", group = "markdown" },
        { "<leader>t", group = "terminal" },
        { "<leader>u", group = "ui/toggle" },

      },
    },
  },
}
