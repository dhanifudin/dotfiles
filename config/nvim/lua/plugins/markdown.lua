return {
  -- Render markdown in-buffer (headings, code blocks, tables, checkboxes)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    ft = { "markdown", "md" },
    opts = {
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        width = "block",
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked   = { icon = "󰱒 " },
      },
    },
  },

  -- Browser preview
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function() vim.fn.jobstart({ "npm", "install" }, { cwd = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app" }) end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown preview toggle" },
    },
  },
}
