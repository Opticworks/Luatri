--[[
local particles = require(script.particles)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))

task.synchronize()

-- svc.run.Heartbeat:ConnectParallel(particles.onHeartbeat)
-- disabled temporarily]]