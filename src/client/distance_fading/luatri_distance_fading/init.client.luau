local fader = require(script.distance_fading)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))

fader.setup()

task.synchronize()
svc.run.Heartbeat:ConnectParallel(fader.onHeartbeat)
print("connected distance fading")