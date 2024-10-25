local trees = require(script.trees)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))

trees.setup()

task.synchronize()
svc.run.Heartbeat:ConnectParallel(trees.onHeartbeat)
print("connected trees")