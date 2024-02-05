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
}
