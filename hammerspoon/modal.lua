k = hs.hotkey.modal.new({'ctrl'}, 'm', 'Enter Modal Mode')

k:bind({}, 'j', function() hs.eventtap.keyStroke({}, 'down') end)
k:bind({}, 'k', function() hs.eventtap.keyStroke({}, 'up') end)

k:bind({}, 'escape', function() k:exit() end)
