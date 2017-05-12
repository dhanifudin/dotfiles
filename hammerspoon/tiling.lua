local tiling = require 'hs.tiling'
local hotkey = require 'hs.hotkey'
local mod = {'alt'}

hotkey.bind(mod, 'return', function() tiling.swapMaster() end)
hotkey.bind(mod, 'h', function() tiling.shrink() end)
hotkey.bind(mod, 'j', function() tiling.focusNext() end)
hotkey.bind(mod, 'k', function() tiling.focusPrevious() end)
hotkey.bind(mod, 'l', function() tiling.expand() end)
hotkey.bind(mod, 'r', function() tiling.retile() end)
hotkey.bind(mod, 'f', function() tiling.goToLayout('full') end)
hotkey.bind(mod, 't', function() tiling.goToLayout('tall') end)
hotkey.bind(mod, 'w', function() tiling.goToLayout('wide') end)
hotkey.bind(mod, 'space', function() tiling.cycleLayout() end)

tiling.set('layouts', {
  'full',
  'tall',
  'wide'
})
