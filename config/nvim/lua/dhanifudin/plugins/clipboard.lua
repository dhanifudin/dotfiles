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
    config = function()
      local installed, yanky = pcall(require, "yanky")
      if installed then
        yanky.setup({})
        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
        vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
        vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
      end
    end,
  },
}