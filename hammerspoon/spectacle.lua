local appkey = {'cmd', 'alt'}

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

hs.hotkey.bind(appkey, 'f', baseMove(0, 0, 1, 1))

hs.hotkey.bind(appkey, 'h', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(appkey, 'j', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(appkey, 'k', baseMove(0, 0, 1, 0.5))
hs.hotkey.bind(appkey, 'l', baseMove(0.5, 0, 0.5, 1))

hs.hotkey.bind(appkey, 'Left', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(appkey, 'Down', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(appkey, 'Up', baseMove(0, 0, 1, 0.5))
hs.hotkey.bind(appkey, 'Right', baseMove(0.5, 0, 0.5, 1))
