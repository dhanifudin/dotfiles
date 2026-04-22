-- runner.lua
-- Task runner (Dispatch, Npm, Composer) backed by snacks.terminal
-- Interactive shell toggle also delegates to snacks.terminal

local M = {}

-- ─── Task Win Config ──────────────────────────────────────────────────────────

local task_win = {
  position = "bottom",
  height = 0.3,
}

-- ─── Core Task Runner ─────────────────────────────────────────────────────────

local function run(cmd, opts)
  opts = opts or {}

  local term = Snacks.terminal.open(cmd, {
    cwd = opts.cwd,
    start_insert = opts.focus or false,
    auto_insert = false,
    auto_close = false,
    win = task_win,
  })

  if term and term.buf then
    local label = type(cmd) == "table" and cmd[#cmd] or cmd
    vim.api.nvim_create_autocmd("TermClose", {
      buffer = term.buf,
      once = true,
      callback = function()
        local code = vim.v.event.status
        vim.schedule(function()
          if code == 0 then
            term:close()
            vim.notify("✓ '" .. label .. "' completed", vim.log.levels.INFO)
          else
            vim.notify("✗ '" .. label .. "' failed (exit " .. code .. ")", vim.log.levels.ERROR)
          end
        end)
      end,
    })
  end

  if not opts.focus then
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
  run({ vim.o.shell, vim.o.shellcmdflag, cmd }, { cwd = root })
end

-- ─── Commands ─────────────────────────────────────────────────────────────────

vim.api.nvim_create_user_command("Dispatch", function(o)
  if o.args == "" then
    vim.notify("Dispatch: No command provided", vim.log.levels.ERROR)
    return
  end
  run({ vim.o.shell, vim.o.shellcmdflag, o.args })
end, { nargs = "+", complete = "shellcmd", desc = "Run command in terminal" })

vim.api.nvim_create_user_command("DispatchFocus", function(o)
  if o.args == "" then
    vim.notify("Dispatch: No command provided", vim.log.levels.ERROR)
    return
  end
  run({ vim.o.shell, vim.o.shellcmdflag, o.args }, { focus = true })
end, { nargs = "+", complete = "shellcmd", desc = "Run command in terminal (focused)" })

-- Npm
local npm_completions = {
  "install", "run", "test", "start", "build", "dev",
  "lint", "format", "update", "uninstall", "init", "publish",
}

vim.api.nvim_create_user_command("Npm", function(o)
  if o.args == "" then
    vim.notify("Npm: No arguments provided", vim.log.levels.ERROR)
    return
  end
  run_in_root("npm " .. o.args, "package.json", "Npm")
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

vim.api.nvim_create_user_command("Composer", function(o)
  if o.args == "" then
    vim.notify("Composer: No arguments provided", vim.log.levels.ERROR)
    return
  end
  run_in_root("composer " .. o.args, "composer.json", "Composer")
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
    if input then run({ vim.o.shell, vim.o.shellcmdflag, input }) end
  end)
end, { desc = "Run dispatch command" })

vim.keymap.set("n", "<leader>rf", function()
  vim.ui.input({ prompt = "Dispatch (focus): " }, function(input)
    if input then run({ vim.o.shell, vim.o.shellcmdflag, input }, { focus = true }) end
  end)
end, { desc = "Run dispatch command (focus)" })

-- Npm
vim.keymap.set("n", "<leader>rn", function()
  vim.ui.input({ prompt = "Npm: " }, function(input)
    if input then vim.cmd("Npm " .. input) end
  end)
end, { desc = "Run npm command" })

vim.keymap.set("n", "<leader>rni", "<cmd>Npm install<cr>",      { desc = "Npm install" })
vim.keymap.set("n", "<leader>rns", "<cmd>Npm start<cr>",        { desc = "Npm start" })
vim.keymap.set("n", "<leader>rnt", "<cmd>Npm test<cr>",         { desc = "Npm test" })
vim.keymap.set("n", "<leader>rnb", "<cmd>Npm run build<cr>",    { desc = "Npm build" })
vim.keymap.set("n", "<leader>rnd", "<cmd>Npm run dev<cr>",      { desc = "Npm dev" })
vim.keymap.set("n", "<leader>rnl", "<cmd>Npm run lint<cr>",     { desc = "Npm lint" })

-- Composer
vim.keymap.set("n", "<leader>rc", function()
  vim.ui.input({ prompt = "Composer: " }, function(input)
    if input then vim.cmd("Composer " .. input) end
  end)
end, { desc = "Run composer command" })

vim.keymap.set("n", "<leader>rci", "<cmd>Composer install<cr>",       { desc = "Composer install" })
vim.keymap.set("n", "<leader>rcu", "<cmd>Composer update<cr>",        { desc = "Composer update" })
vim.keymap.set("n", "<leader>rct", "<cmd>Composer test<cr>",          { desc = "Composer test" })
vim.keymap.set("n", "<leader>rcd", "<cmd>Composer dump-autoload<cr>", { desc = "Composer dump-autoload" })

return M
