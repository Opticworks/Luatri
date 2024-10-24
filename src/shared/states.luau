local states = {}

states.convertedGUILoaded = false
states.GUIControllerLoaded = false
states._convertedGUILoadedBindable = Instance.new("BindableEvent")
states._GUIControllerLoadedBindable = Instance.new("BindableEvent")
states._GUIControllerLoadedEvent = states._GUIControllerLoadedBindable.Event
states._convertedGUILoadedBindableEvent = states._convertedGUILoadedBindable.Event

states.camPos = workspace.CurrentCamera.CFrame.Position -- this gets set once and updated later by a single Heartbeat 

return states
