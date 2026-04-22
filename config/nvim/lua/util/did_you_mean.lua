-- did_you_mean.lua
-- When opening a non-existent file, suggest similarly-named files
-- in the same directory (similar to github.com/EinfachToll/DidYouMean)

local M = {}

--- Find files in `dir` whose names contain `query` as a substring (case-insensitive).
---@param dir string
---@param query string
---@return string[]
local function find_candidates(dir, query)
  local candidates = {}
  local q = query:lower()

  local handle = vim.uv.fs_opendir(dir, nil, 256)
  if not handle then return candidates end

  repeat
    local entries = vim.uv.fs_readdir(handle)
    if entries then
      for _, entry in ipairs(entries) do
        if entry.name:lower():find(q, 1, true) then
          table.insert(candidates, entry.name)
        end
      end
    end
  until not entries

  vim.uv.fs_closedir(handle)
  return candidates
end

function M.setup()
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("did_you_mean", { clear = true }),
    callback = function(ev)
      local fname = vim.api.nvim_buf_get_name(ev.buf)
      if fname == "" then return end

      -- Skip if the file actually exists (e.g. created by another process)
      if vim.uv.fs_stat(fname) then return end

      -- Skip unnamed, special, or remote buffers
      if fname:match("^%w+://") then return end

      local dir  = vim.fn.fnamemodify(fname, ":h")
      local base = vim.fn.fnamemodify(fname, ":t")
      if base == "" then return end

      -- Ensure the directory itself exists before scanning
      if not vim.uv.fs_stat(dir) then return end

      local candidates = find_candidates(dir, base)
      if #candidates == 0 then return end

      -- Exact match means no suggestion needed
      for _, c in ipairs(candidates) do
        if c == base then return end
      end

      vim.schedule(function()
        vim.ui.select(candidates, {
          prompt = ('"%s" not found. Did you mean?'):format(base),
        }, function(choice)
          if choice then
            local target = vim.fn.fnamemodify(dir .. "/" .. choice, ":p")
            -- Replace current empty buffer with the chosen file
            vim.cmd("edit " .. vim.fn.fnameescape(target))
          end
        end)
      end)
    end,
  })
end

return M
