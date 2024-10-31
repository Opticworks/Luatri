local interior = {}

local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)
local msg = require(svc.replicatedStorage.output)
local state = require(svc.replicatedStorage.states)

local interiorFolder = workspace:WaitForChild("Interiors",math.huge)

local cullRegions = {}
local initialTransparencyMap = {}
local activeCullFolders = {}
local cullingEnabled = true

function interior.setModelVisibility(model, visible)
	visible = not visible
	for _, descendant in pairs(model:GetDescendants()) do
		if descendant:IsA("BasePart") then
			if initialTransparencyMap[descendant] == nil then
				initialTransparencyMap[descendant] = descendant.Transparency
			end
			descendant.Transparency = visible and initialTransparencyMap[descendant] or 1
			descendant.CanCollide = visible
		end
	end
end

function interior.setFolderVisibility(folder, visible)
	for _, item in pairs(folder:GetChildren()) do
		if item.Name ~= "cullBrush" then
			if item:IsA("Model") then
				interior.setModelVisibility(item, visible)
			elseif item:IsA("BasePart") then
				if initialTransparencyMap[item] == nil then
					initialTransparencyMap[item] = item.Transparency
				end
				item.Transparency = visible and initialTransparencyMap[item] or 1
				item.CanCollide = visible
			end
		end
	end
end

function interior.setup()
	for _, folder in pairs(interiorFolder:GetChildren()) do
		local cullBrush = folder:FindFirstChild("cullBrush")
		if cullBrush and cullBrush:IsA("BasePart") then
			local size = cullBrush.Size / 2
			local minPos = cullBrush.Position - size
			local maxPos = cullBrush.Position + size
			table.insert(cullRegions, {
				minPos = minPos,
				maxPos = maxPos,
				folder = folder,
				part = cullBrush,
			})
		else
			if folder then
				msg.throw(1 .. " for " .. tostring(folder), "warn")
			else
				msg.throw(2, "warn")
			end
		end
	end
end

function interior.isCameraInRegion(minPos, maxPos) -- todo: get rid of this crap
	local camPos = state.camPos
	return camPos.X >= minPos.X
		and camPos.X <= maxPos.X
		and camPos.Y >= minPos.Y
		and camPos.Y <= maxPos.Y
		and camPos.Z >= minPos.Z
		and camPos.Z <= maxPos.Z
end

function interior.showAllItems()
	for _, data in pairs(cullRegions) do
		interior.setFolderVisibility(data.folder, true)
	end
	activeCullFolders = {}
end

function interior.cullFolder(folder)
	interior.setFolderVisibility(folder, false)
	activeCullFolders[folder] = true
end

function interior.restoreFolderVisibility(folder)
	interior.setFolderVisibility(folder, true)
	activeCullFolders[folder] = nil
end

function interior.updateCulling()
	local foldersToCull = {}
	local foldersToUncull = {}
	for _, data in pairs(cullRegions) do
		local minPos = data.minPos
		local maxPos = data.maxPos
		local folder = data.folder
		if interior.isCameraInRegion(minPos, maxPos) then
			if not activeCullFolders[folder] then
				foldersToCull[folder] = true
			end
		else
			if activeCullFolders[folder] then
				foldersToUncull[folder] = true
			end
		end
	end
	for folder in pairs(foldersToCull) do
		interior.cullFolder(folder)
	end
	for folder in pairs(foldersToUncull) do
		interior.restoreFolderVisibility(folder)
	end
end
function interior.onHeartbeat()
	if cfg.InteriorCulling ~= cullingEnabled then
		cullingEnabled = cfg.InteriorCulling
		if not cullingEnabled then
			interior.showAllItems()
		end
	end
	if cullingEnabled then
		interior.updateCulling()
	end
end

return interior
