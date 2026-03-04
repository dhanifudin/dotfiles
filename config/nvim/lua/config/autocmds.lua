-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Function to set theme based on time of day.
-- Only reloads the colorscheme when the background actually changes,
-- avoiding an expensive full reload on every hourly tick.
local function set_theme_by_time()
  local hour = tonumber(os.date("%H"))
  local target = (hour >= 7 and hour < 18) and "light" or "dark"
  if vim.o.background == target then
    return
  end
  vim.o.background = target
  vim.cmd("colorscheme catppuccin")
end

-- Set theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = set_theme_by_time,
})

-- Check and update theme every hour (vim.uv replaces the deprecated vim.loop)
local timer = vim.uv.new_timer()
timer:start(
  3600000, -- first tick after one hour; VimEnter handles startup
  3600000,
  vim.schedule_wrap(set_theme_by_time)
)

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
