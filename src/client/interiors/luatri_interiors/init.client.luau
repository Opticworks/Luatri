local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))

local interiors = require(script.interiors)
interiors.setup()

task.synchronize()

svc.run.Heartbeat:ConnectParallel(interiors.onHeartbeat)
