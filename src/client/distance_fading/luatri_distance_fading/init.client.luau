local fader = require(script.distance_fading)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)

fader.setup()

task.synchronize()

if cfg.SERIAL_MODE then
    svc.run.Heartbeat:Connect(fader.onHeartbeat)
else
    svc.run.Heartbeat:ConnectParallel(fader.onHeartbeat)
end