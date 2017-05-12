local fnutils = require 'hs.fnutils'
local resize = 0
local layouts = {}

function layouts.resize(size)
  resize = resize + size
end

layouts['full'] = function(windows)
  fnutils.each(windows, function(window)
    window:maximize()
  end)
end

layouts['tall'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['full'](windows)
  end

  for index, win in pairs(windows) do
    local frame = win:screen():frame()

    if index == 1 then
      frame.w = (frame.w / 2) + (resize)
    else
      frame.x = (frame.x + frame.w / 2) + (resize)
      frame.w = (frame.w / 2) - (resize)
      frame.h = frame.h / (winCount - 1)
      frame.y = frame.y + frame.h * (index - 2)
    end

    win:setFrame(frame)
  end
end

layouts['wide'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['full'](windows)
  end

  for index, win in pairs(windows) do
    local frame = win:screen():frame()

    if index == 1 then
      frame.h = (frame.h / 2) + (resize)
    else
      frame.y = (frame.y + frame.h / 2) + (resize)
      frame.h = (frame.h / 2) - (resize)
      frame.w = frame.w / (winCount - 1)
      frame.x = frame.x + frame.w * (index - 2)
    end

    win:setFrame(frame)
  end
end

return layouts
