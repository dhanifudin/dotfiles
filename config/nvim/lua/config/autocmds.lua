-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Function to set theme based on time of day
local function set_theme_by_time()
  local hour = tonumber(os.date("%H"))

  -- Working hours: 7 AM to 6 PM (light theme)
  -- Night time: 6 PM to 7 AM (dark theme)
  if hour >= 7 and hour < 18 then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end

  -- Reload colorscheme to apply the change
  vim.cmd("colorscheme catppuccin")
end

-- Set theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    set_theme_by_time()
  end,
})

-- Optional: Check and update theme every hour
local timer = vim.loop.new_timer()
timer:start(
  0,
  3600000, -- Check every hour (3600000 ms)
  vim.schedule_wrap(function()
    set_theme_by_time()
  end)
)

-- Focus diff: when diff mode is enabled, close all non-diff windows in the tab
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
        -- Skip floating windows and windows already in diff mode
        local cfg = vim.api.nvim_win_get_config(win)
        if cfg.relative == "" and not vim.wo[win].diff then
          pcall(vim.api.nvim_win_close, win, false)
        end
      end
    end)
  end,
})
