-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Close certain filetypes with q
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = { "help", "man", "qf", "lspinfo", "notify", "checkhealth", "query" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- "Did you mean?" suggestions for mistyped filenames
require("util.did_you_mean").setup()

-- Returns true if the window belongs to an AI panel (ClaudeCode or OpenCode)
local function is_ai_panel(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local ft = vim.bo[buf].filetype
  local name = vim.api.nvim_buf_get_name(buf):lower()
  local ai_filetypes = { claudecode = true, opencode = true }
  if ai_filetypes[ft] then
    return true
  end
  return name:find("claude") ~= nil or name:find("opencode") ~= nil
end

-- Focus diff: when diff mode is enabled, close all non-diff windows in the tab,
-- except floating windows and AI panels (ClaudeCode, OpenCode)
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  group = vim.api.nvim_create_augroup("diff_focus", { clear = true }),
  callback = function()
    if not vim.v.option_new then
      return
    end
    vim.schedule(function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      for _, win in ipairs(wins) do
        local cfg = vim.api.nvim_win_get_config(win)
        local is_floating = cfg.relative ~= ""
        local in_diff = vim.wo[win].diff
        if not is_floating and not in_diff and not is_ai_panel(win) then
          pcall(vim.api.nvim_win_close, win, false)
        end
      end
    end)
  end,
})
