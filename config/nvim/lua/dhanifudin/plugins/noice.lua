return {
  "folke/noice.nvim",
  config = function()
    local installed, noice = pcall(require, "noice")
    if installed then
      noice.setup({
        messages = {
          enabled = false,
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
      })
    end
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}