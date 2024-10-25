
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local states = require(svc.replicatedStorage.states)

svc.run.Heartbeat:Connect(function()
	states.camPos = workspace.CurrentCamera.CFrame.Position
end)




