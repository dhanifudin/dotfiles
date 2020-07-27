local hotkey = require 'hotkey'
local spectacle = require 'spectacle'

function applicationWatcherCallback(appName, eventType, appObject)
  if (appName == "VirtualBox VM") then
    if (eventType == hs.application.watcher.activated) then
      hotkey:exit()
      spectacle:exit()
    elseif (eventType == hs.application.watcher.deactivated) then
      hotkey:enter()
      spectacle:enter()
    end
  end
end

watcher = hs.application.watcher.new(applicationWatcherCallback)
watcher:start()

hotkey:enter()
spectacle:enter()
