return {
  {
    "variable-segment-textobj",
    dir = vim.fn.stdpath("config"),
    name = "variable-segment-textobj",
    event = "VeryLazy",
    config = function()
      require("util.variable_segment").setup()
    end,
  },
}
