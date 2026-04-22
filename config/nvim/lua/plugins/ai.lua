return {
  {
    "folke/sidekick.nvim",
    config = function(_, opts)
      require("sidekick").setup(opts)
    end,
    opts = {
      cli = {
        picker = "snacks",
        mux = {
          backend = "tmux",
          enabled = false,
        },
        win = {
          layout = "bottom",
          split = {
            height = 20,
          },
        },
      },
    },
    keys = {
      {
        "<tab>",
        function() return require("sidekick").nes_jump_or_apply() end,
        expr = true,
        desc = "NES jump or apply",
      },
      { "<leader>aa", function() require("sidekick.cli").toggle() end,            desc = "AI toggle" },
      { "<leader>as", function() require("sidekick.cli").select() end,            desc = "AI select tool" },
      { "<leader>ac", function() require("sidekick.cli").toggle("claude") end,    desc = "AI open Claude" },
      { "<leader>ao", function() require("sidekick.cli").toggle("opencode") end,  desc = "AI open OpenCode" },
      { "<leader>aq", function() require("sidekick.cli").toggle("qwen") end,      desc = "AI open Qwen" },
    },
  },
}
