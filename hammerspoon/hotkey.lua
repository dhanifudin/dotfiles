local application = require 'hs.application'
local hotkey = require 'hs.hotkey'
local appkey = {'cmd', 'alt'}

hotkey.bind(appkey, 'r', function()
  hs.reload()
  hs.alert('Reload hammerspoon configuration.')
end)

hotkey.bind(appkey, 'a', function()
  application.launchOrFocus('Android Studio.app')
end)

hotkey.bind(appkey, 'c', function()
  application.launchOrFocus('Google Chrome.app')
end)

hotkey.bind(appkey, 'w', function()
  application.launchOrFocus('Firefox.app')
end)

hotkey.bind(appkey, 'i', function()
  application.launchOrFocus('IntelliJ IDEA CE.app')
end)

hotkey.bind(appkey, 't', function()
  application.launchOrFocus('iTerm.app')
end)

hotkey.bind(appkey, 'e', function()
  application.launchOrFocus('Emacs.app')
end)

hotkey.bind(appkey, 'm', function()
  application.launchOrFocus('Rambox.app')
end)

hotkey.bind(appkey, 'z', function()
  application.launchOrFocus('Zeal.app')
end)
