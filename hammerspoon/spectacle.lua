local appkey = {'cmd', 'alt'}
local hotkey = hs.hotkey.modal.new(appkey)

function baseMove(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.w * x
    f.y = max.h * y
    f.w = max.w * w
    f.h = max.h * h
    win:setFrame(f)
  end
end

hotkey:bind(appkey, 'f', nil, baseMove(0, 0, 1, 1))

hotkey:bind(appkey, 'h', nil, baseMove(0, 0, 0.5, 1))
hotkey:bind(appkey, 'j', nil, baseMove(0, 0.5, 1, 0.5))
hotkey:bind(appkey, 'k', nil, baseMove(0, 0, 1, 0.5))
hotkey:bind(appkey, 'l', nil, baseMove(0.5, 0, 0.5, 1))

hotkey:bind(appkey, 'Left', nil, baseMove(0, 0, 0.5, 1))
hotkey:bind(appkey, 'Down', nil, baseMove(0, 0.5, 1, 0.5))
hotkey:bind(appkey, 'Up', nil, baseMove(0, 0, 1, 0.5))
hotkey:bind(appkey, 'Right', nil, baseMove(0.5, 0, 0.5, 1))

return hotkey
