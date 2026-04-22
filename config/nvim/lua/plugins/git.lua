return {
  -- Git pickers and commands via snacks.picker + runner
  {
    "folke/snacks.nvim",
    optional = true,
    keys = {
      -- Pickers (interactive)
      { "<leader>gb", function() Snacks.picker.git_branches() end,  desc = "Git branches (checkout/create/delete)" },
      { "<leader>gc", function() Snacks.picker.git_log() end,       desc = "Git log (checkout commit)" },
      { "<leader>gs", function() Snacks.picker.git_status() end,    desc = "Git status (stage/unstage/restore)" },
      { "<leader>gS", function() Snacks.picker.git_stash() end,     desc = "Git stash (apply)" },
      { "<leader>gd", function() Snacks.picker.git_diff() end,      desc = "Git diff (stage/restore)" },
      { "<leader>gL", function() Snacks.picker.git_log_file() end,  desc = "Git file history" },

      -- Commands (run via snacks terminal, project root auto-detected by cwd)
      { "<leader>gp", function() Snacks.terminal.open("git pull",           { win = { position = "bottom", height = 0.3 } }) end, desc = "Git pull" },
      { "<leader>gP", function() Snacks.terminal.open("git push",           { win = { position = "bottom", height = 0.3 } }) end, desc = "Git push" },
      { "<leader>gF", function() Snacks.terminal.open("git fetch --all",    { win = { position = "bottom", height = 0.3 } }) end, desc = "Git fetch" },
      { "<leader>gX", function()
          vim.ui.input({ prompt = "git push --force-with-lease " }, function(args)
            if args then
              Snacks.terminal.open("git push --force-with-lease " .. args, { win = { position = "bottom", height = 0.3 } })
            end
          end)
        end, desc = "Git push force-with-lease" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buf, desc = desc, silent = true })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")

        -- Actions
        map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
        map("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>ghd", gs.diffthis, "Diff this")
      end,
    },
  },
}
