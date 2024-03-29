local application = require 'hs.application'
local appkey = 'cmd-alt'
local hotkey = hs.hotkey.modal.new(appkey)

function focus(app)
  return function()
    application.launchOrFocus(app)
  end
end

hotkey:bind(appkey, 'r', nil, function()
  hs.reload()
  hs.alert.show('Reload hammerspoon configuration.')
end)

hotkey:bind(appkey, 'f', nil, focus('Firefox.app'))
hotkey:bind(appkey, 't', nil, focus('iTerm.app'))
hotkey:bind(appkey, 'c', nil, focus('Telegram.app'))
hotkey:bind(appkey, 'w', nil, focus('Whatsapp.app'))
hotkey:bind(appkey, 's', nil, focus('Spotify.app'))

return hotkey
