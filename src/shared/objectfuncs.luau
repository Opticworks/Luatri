local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local func = require(svc.replicatedStorage.funcs)

local obj = {}

function obj.canSetTransparency(object)
    local bool = object:IsA("BasePart") or object:IsA("MeshPart") or object:IsA("Decal") or object:IsA("SpecialMesh")
    return bool
end

function obj.setModelTransparency(model, transparency: number)
    for _, descendant in pairs(model:GetDescendants()) do
        if obj.canSetTransparency(descendant) then
            descendant.Transparency = transparency
        end
    end
end

function obj.tweenModelTransparency(model, transparency: number)
    for _, descendant in pairs(model:GetDescendants()) do
        if obj.canSetTransparency(descendant) then
            func.tween(descendant, TweenInfo.new(0.25), { Transparency = transparency })
        end
    end
end


return obj
