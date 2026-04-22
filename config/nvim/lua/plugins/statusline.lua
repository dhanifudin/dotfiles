return {
  -- Icons (replaces nvim-web-devicons)
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- Statusline
  {
    "nvim-mini/mini.statusline",
    dependencies = { "nvim-mini/mini.icons" },
    event = "VeryLazy",
    opts = {
      use_icons = true,
    },
  },
}
