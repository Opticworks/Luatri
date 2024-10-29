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

return obj
