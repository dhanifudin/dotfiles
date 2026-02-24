-- runner.lua
-- Terminal command runner with Dispatch, Npm and Composer wrappers
-- Auto-closes terminal and sends notification on process exit

local M = {}

-- ─── State ────────────────────────────────────────────────────────────────────

local state = {
  buf = nil,
  win = nil,
  term_id = nil,
}

-- ─── Core Terminal Runner ──────────────────────────────────────────────────────

local function close_terminal()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
  end
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    vim.api.nvim_buf_delete(state.buf, { force = true })
    state.buf = nil
  end
  state.term_id = nil
end

local function open_terminal(height)
  -- Close any existing dispatch window
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  vim.cmd("botright " .. (height or 15) .. "split")
  state.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(state.buf, "bufhidden", "hide")
  state.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(state.win, state.buf)
  vim.api.nvim_win_set_option(state.win, "number", false)
  vim.api.nvim_win_set_option(state.win, "relativenumber", false)
  vim.api.nvim_win_set_option(state.win, "signcolumn", "no")
end

local function run(cmd, opts)
  opts = opts or {}
  local focus = opts.focus or false

  open_terminal(opts.height)

  local shell_cmd = vim.o.shell .. " -c '" .. cmd:gsub("'", "'\\''") .. "'"

  state.term_id = vim.fn.termopen(shell_cmd, {
    on_exit = function(_, exit_code, _)
      vim.schedule(function()
        close_terminal()
        if exit_code == 0 then
          vim.notify("✓ '" .. cmd .. "' completed", vim.log.levels.INFO)
        else
          vim.notify("✗ '" .. cmd .. "' failed (exit code " .. exit_code .. ")", vim.log.levels.ERROR)
        end
      end)
    end,
  })

  vim.api.nvim_buf_set_name(state.buf, "runner: " .. cmd)

  if not focus then
    vim.cmd("wincmd p")
  end
end

-- ─── Project Root Detection ────────────────────────────────────────────────────

local function find_project_root(marker)
  local from = vim.fn.expand("%:p:h")
  local found = vim.fn.findfile(marker, from .. ";")
  if found == "" then
    found = vim.fn.findfile(marker, vim.fn.getcwd() .. ";")
  end
  if found ~= "" then
    return vim.fn.fnamemodify(found, ":p:h")
  end
end

local function run_in_root(cmd, marker, label)
  local root = find_project_root(marker)
  if not root then
    vim.notify(label .. ": " .. marker .. " not found", vim.log.levels.ERROR)
    return
  end
  run(string.format("cd '%s' && %s", root, cmd))
end

-- ─── Commands ─────────────────────────────────────────────────────────────────

-- Dispatch
vim.api.nvim_create_user_command("Dispatch", function(opts)
  if opts.args == "" then
    vim.notify("Dispatch: No command provided", vim.log.levels.ERROR)
    return
  end
  run(opts.args)
end, { nargs = "+", complete = "shellcmd", desc = "Run command in terminal" })

vim.api.nvim_create_user_command("DispatchFocus", function(opts)
  if opts.args == "" then
    vim.notify("Dispatch: No command provided", vim.log.levels.ERROR)
    return
  end
  run(opts.args, { focus = true })
end, { nargs = "+", complete = "shellcmd", desc = "Run command in terminal (focused)" })

vim.api.nvim_create_user_command("DispatchToggle", function()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
  elseif state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    vim.cmd("botright 15split")
    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(state.win, state.buf)
    vim.cmd("wincmd p")
  end
end, { desc = "Toggle dispatch terminal" })

-- Npm
local npm_completions = {
  "install", "run", "test", "start", "build", "dev",
  "lint", "format", "update", "uninstall", "init", "publish",
}

vim.api.nvim_create_user_command("Npm", function(opts)
  if opts.args == "" then
    vim.notify("Npm: No arguments provided", vim.log.levels.ERROR)
    return
  end
  run_in_root("npm " .. opts.args, "package.json", "Npm")
end, {
  nargs = "+",
  complete = function(arg_lead, cmd_line)
    if #vim.split(cmd_line, "%s+") <= 2 then
      return vim.tbl_filter(function(c) return c:find(arg_lead, 1, true) == 1 end, npm_completions)
    end
  end,
  desc = "Run npm command from project root",
})

-- Composer
local composer_completions = {
  "install", "require", "update", "remove", "dump-autoload",
  "init", "test", "run", "validate", "status", "create-project",
}

vim.api.nvim_create_user_command("Composer", function(opts)
  if opts.args == "" then
    vim.notify("Composer: No arguments provided", vim.log.levels.ERROR)
    return
  end
  run_in_root("composer " .. opts.args, "composer.json", "Composer")
end, {
  nargs = "+",
  complete = function(arg_lead, cmd_line)
    if #vim.split(cmd_line, "%s+") <= 2 then
      return vim.tbl_filter(function(c) return c:find(arg_lead, 1, true) == 1 end, composer_completions)
    end
  end,
  desc = "Run composer command from project root",
})

-- ─── Keymaps ──────────────────────────────────────────────────────────────────

-- Dispatch
vim.keymap.set("n", "<leader>rd", function()
  vim.ui.input({ prompt = "Dispatch: " }, function(input)
    if input then run(input) end
  end)
end, { desc = "Run dispatch command" })

vim.keymap.set("n", "<leader>rf", function()
  vim.ui.input({ prompt = "Dispatch (focus): " }, function(input)
    if input then run(input, { focus = true }) end
  end)
end, { desc = "Run dispatch command (focus)" })

vim.keymap.set("n", "<leader>rt", "<cmd>DispatchToggle<cr>", { desc = "Toggle dispatch window" })

-- Npm
vim.keymap.set("n", "<leader>rn", function()
  vim.ui.input({ prompt = "Npm: " }, function(input)
    if input then vim.cmd("Npm " .. input) end
  end)
end, { desc = "Run npm command" })

vim.keymap.set("n", "<leader>rni", "<cmd>Npm install<cr>",     { desc = "Npm install" })
vim.keymap.set("n", "<leader>rns", "<cmd>Npm start<cr>",       { desc = "Npm start" })
vim.keymap.set("n", "<leader>rnt", "<cmd>Npm test<cr>",        { desc = "Npm test" })
vim.keymap.set("n", "<leader>rnb", "<cmd>Npm run build<cr>",   { desc = "Npm build" })
vim.keymap.set("n", "<leader>rnd", "<cmd>Npm run dev<cr>",     { desc = "Npm dev" })
vim.keymap.set("n", "<leader>rnl", "<cmd>Npm run lint<cr>",    { desc = "Npm lint" })

-- Composer
vim.keymap.set("n", "<leader>rc", function()
  vim.ui.input({ prompt = "Composer: " }, function(input)
    if input then vim.cmd("Composer " .. input) end
  end)
end, { desc = "Run composer command" })

vim.keymap.set("n", "<leader>rci", "<cmd>Composer install<cr>",      { desc = "Composer install" })
vim.keymap.set("n", "<leader>rcu", "<cmd>Composer update<cr>",       { desc = "Composer update" })
vim.keymap.set("n", "<leader>rct", "<cmd>Composer test<cr>",         { desc = "Composer test" })
vim.keymap.set("n", "<leader>rcd", "<cmd>Composer dump-autoload<cr>",{ desc = "Composer dump-autoload" })
