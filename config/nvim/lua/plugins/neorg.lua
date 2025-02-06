return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    opts = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
        },
      })
    end,
  },
}
