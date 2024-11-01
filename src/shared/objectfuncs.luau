local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local func = require(svc.replicatedStorage.funcs)

local obj = {}

local compatibleInstance = {
    "Decal",
    "BasePart",
    "MeshPart",
    "SpecialMesh"
}

function obj.canSetTransparency(object)
    for _,goodboy in compatibleInstance do
        if object:IsA(goodboy) then -- awrf
            return true
        end
    end
    return false
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
