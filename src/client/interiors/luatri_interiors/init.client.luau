local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)

local interiors = require(script.interiors)
interiors.setup()

task.synchronize()

if cfg.SERIAL_MODE then
    svc.run.Heartbeat:Connect(interiors.onHeartbeat)
else
    svc.run.Heartbeat:ConnectParallel(interiors.onHeartbeat)
end