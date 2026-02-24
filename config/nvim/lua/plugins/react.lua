return {
  -- Auto tag closing for JSX/TSX
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },

  -- Package.json support
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    keys = {
      { "<leader>cps", "<cmd>lua require('package-info').show()<cr>", desc = "Show package info" },
      { "<leader>cpc", "<cmd>lua require('package-info').hide()<cr>", desc = "Hide package info" },
      { "<leader>cpu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
      { "<leader>cpd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
      { "<leader>cpi", "<cmd>lua require('package-info').install()<cr>", desc = "Install package" },
      { "<leader>cpr", "<cmd>lua require('package-info').reinstall()<cr>", desc = "Reinstall dependencies" },
      { "<leader>cpp", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change package version" },
    },
    opts = {},
  },
}
