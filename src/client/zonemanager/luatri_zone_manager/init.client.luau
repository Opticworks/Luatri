local zones = require(script.zone_manager)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))

task.synchronize()

svc.run.Heartbeat:Connect(zones.onHeartbeat)