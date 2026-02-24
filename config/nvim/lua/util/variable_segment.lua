local M = {}

-- Find all variable segments in a word string.
-- Handles camelCase, PascalCase, snake_case, SCREAMING_SNAKE, and mixed.
-- Returns list of {start, end} (1-indexed, inclusive).
local function find_segments(word)
  local segments = {}
  local i = 1
  local len = #word

  while i <= len do
    local c = word:sub(i, i)
    if c == "_" then
      i = i + 1
    elseif c:match("%u") then
      local next_c = word:sub(i + 1, i + 1)
      if next_c:match("[%l%d]") then
        -- CamelCase word: Foo, Bar, Http2
        local j = i + 1
        while j <= len and word:sub(j, j):match("[%l%d]") do
          j = j + 1
        end
        table.insert(segments, { i, j - 1 })
        i = j
      else
        -- ACRONYM: HTTP, XML — stop before a new CamelCase word
        local e = i
        while e < len do
          local nxt = word:sub(e + 1, e + 1)
          if nxt:match("%u") then
            if word:sub(e + 2, e + 2):match("[%l%d]") then
              break
            end
            e = e + 1
          else
            break
          end
        end
        table.insert(segments, { i, e })
        i = e + 1
      end
    elseif c:match("[%l%d]") then
      -- Lowercase/digit run: foo, bar, http2
      local j = i
      while j <= len and word:sub(j, j):match("[%l%d]") do
        j = j + 1
      end
      table.insert(segments, { i, j - 1 })
      i = j
    else
      i = i + 1
    end
  end

  return segments
end

-- Returns {start_col, end_col} (0-indexed) for the segment at cursor, or nil.
local function get_segment_range(include_separator)
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-indexed

  -- Only proceed if cursor is on a letter or digit (not underscore)
  if not line:sub(col + 1, col + 1):match("%w") then
    return nil
  end

  -- Expand left: check the char to the left of wstart (1-indexed == 0-indexed wstart)
  local wstart = col
  while wstart > 0 and line:sub(wstart, wstart):match("[%w_]") do
    wstart = wstart - 1
  end
  if not line:sub(wstart + 1, wstart + 1):match("[%w_]") then
    wstart = wstart + 1
  end

  -- Expand right
  local wend = col
  while wend < #line - 1 and line:sub(wend + 2, wend + 2):match("[%w_]") do
    wend = wend + 1
  end

  local word = line:sub(wstart + 1, wend + 1)
  local cursor_in_word = col - wstart + 1 -- 1-indexed position within word

  local segments = find_segments(word)
  local seg_idx
  for idx, seg in ipairs(segments) do
    if cursor_in_word >= seg[1] and cursor_in_word <= seg[2] then
      seg_idx = idx
      break
    end
  end

  if not seg_idx then
    return nil
  end

  local s = segments[seg_idx][1]
  local e = segments[seg_idx][2]

  if include_separator then
    -- Prefer trailing underscore, fall back to leading
    if word:sub(e + 1, e + 1) == "_" then
      e = e + 1
    elseif s > 1 and word:sub(s - 1, s - 1) == "_" then
      s = s - 1
    end
  end

  return {
    start_col = wstart + s - 1, -- 0-indexed
    end_col = wstart + e - 1, -- 0-indexed
  }
end

local function select_segment(include_separator)
  local range = get_segment_range(include_separator)
  if not range then
    return
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]
  local mode = vim.api.nvim_get_mode().mode

  if mode == "v" or mode == "V" or mode:sub(1, 1) == "\22" then
    -- Visual mode: exit, reposition, and restart selection
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    vim.api.nvim_win_set_cursor(0, { row, range.start_col })
    vim.api.nvim_feedkeys("v", "x", false)
    vim.api.nvim_win_set_cursor(0, { row, range.end_col })
  else
    -- Operator-pending: move to start, open visual, extend to end
    vim.api.nvim_win_set_cursor(0, { row, range.start_col })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { row, range.end_col })
  end
end

function M.setup()
  vim.keymap.set({ "x", "o" }, "iv", function()
    select_segment(false)
  end, { desc = "Inner variable segment" })

  vim.keymap.set({ "x", "o" }, "av", function()
    select_segment(true)
  end, { desc = "Around variable segment" })
end

return M
