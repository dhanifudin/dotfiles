return {
  "windpwp/nvim-autopairs",
  dependencies = {
    "windpwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-autopairs").setup({
      disable_filetype = { "TelescopePrompt", "vim" },
    })

    require("nvim-ts-autotag").setup()
  end,
}