-- this is just for the showcase video...

local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))


svc.userInput.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.Semicolon then
        svc.lighting.Atmosphere.Density = 0.276

    end
end)