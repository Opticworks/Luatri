
local trees = require(script.trees)
local interiors = require(script.interiors)
local particles = require(script.particles)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local states = require(svc.replicatedStorage.states)

if not states.GUIControllerLoaded then
	states._GUIControllerLoadedEvent:Wait()
end
interiors.setup()
trees.setup()

task.synchronize()

svc.run.Heartbeat:ConnectParallel(trees.onHeartbeat)
svc.run.Heartbeat:ConnectParallel(interiors.onHeartbeat)
svc.run.Heartbeat:ConnectParallel(particles.onHeartbeat)


