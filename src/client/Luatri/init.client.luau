--!nocheck

local trees = require(script.trees)
local interiors = require(script.interiors)
local particles = require(script.particles)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))

local states = require(svc.replicatedStorage.states)

repeat
	task.wait()
until states.GUIControllerLoaded



interiors.setup()
trees.setup()

svc.run.Heartbeat:Connect(trees.onHeartbeat)
svc.run.Heartbeat:Connect(interiors.onHeartbeat)
svc.run.Heartbeat:Connect(particles.onHeartbeat)

