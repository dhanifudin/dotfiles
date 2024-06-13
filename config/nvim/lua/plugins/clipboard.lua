return {
  {
    "gbprod/cutlass.nvim",
    config = function()
      local installed, cutlass = pcall(require, "cutlass")
      if installed then
        cutlass.setup({
          cut_key = "m",
        })
      end
    end,
  },
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = { timer = 250 },
      ring = { storage = "shada" },
      preserve_cursor_position = {
        enabled = true
      }
    }
  }
}
