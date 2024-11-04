
local particles = require(script.particles)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)

task.synchronize()

if cfg.SERIAL_MODE then
    svc.run.Heartbeat:Connect(particles.onHeartbeat)
else
    svc.run.Heartbeat:ConnectParallel(particles.onHeartbeat)
end
