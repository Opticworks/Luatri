--!nocheck
_G.VisTools_InteriorCulling = true
_G.VisTools_ParticleCulling = true
_G.VisTools_TreeImpostors = false -- TODO: Billboards increase drawcalls :( Switch to decals
_G.VisTools_TreeImpostors_output = false
_G.VisTools_TreeImpostors_batch_output = true
_G.VisTools_InteriorCulling_output = true
_G.VisTools_ParticleCulling_output = false
_G.VisTools_DistanceFading = true
_G.VisTools_DistanceFading_output = true

repeat task.wait(10) until game:IsLoaded()

local runService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

-- Configuration

local PARTICLE_THRESHOLD_DISTANCE = 300
local TREE_THRESHOLD_DISTANCE = 700
local TREE_CHECK_INTERVAL = 0.4
local TREE_BATCH_SIZE = 30
local TREE_WARNING_MS = 0.1
local TREE_BATCH_WARNING_MS = 0.5
local TREE_FOLDER = workspace:WaitForChild("Trees")

-- Interior culling

local camera = workspace.CurrentCamera
local interiorFolder = game:GetService("Workspace"):WaitForChild("Interiors")

local cullRegions = {}
local initialTransparencyMap = {}
local activeCullFolders = {}
local cullingEnabled = true

local function setModelVisibility(model, visible)
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

local function setFolderVisibility(folder, visible)
	for _, item in pairs(folder:GetChildren()) do
		if item.Name ~= "cullBrush" then
			if item:IsA("Model") then
				setModelVisibility(item, visible)
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

local function setupCullBrushRegions()
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
				part = cullBrush
			})
		else
			if folder then
				_G.out("<b>[FATAL VISTOOLS INTERIOR CULLING ERROR]</b> Cull brush not found or invalid for folder: " .. folder.Name)
			else
				_G.out("<b>[FATAL VISTOOLS INTERIOR CULLING ERROR]</b> Cull brush not found or invalid for an unknown folder")
			end
		end
	end
end

local function isCameraInRegion(minPos, maxPos)
	local camPos = camera.CFrame.Position
	return camPos.X >= minPos.X and camPos.X <= maxPos.X and
		camPos.Y >= minPos.Y and camPos.Y <= maxPos.Y and
		camPos.Z >= minPos.Z and camPos.Z <= maxPos.Z
end

local function showAllItems()
	for _, data in pairs(cullRegions) do
		setFolderVisibility(data.folder, true)
	end
	activeCullFolders = {}
end

local function cullFolder(folder)
	setFolderVisibility(folder, false)
	activeCullFolders[folder] = true
end

local function restoreFolderVisibility(folder)
	setFolderVisibility(folder, true)
	activeCullFolders[folder] = nil
end

local function updateCulling()
	local camPos = camera.CFrame.Position
	local foldersToCull = {}
	local foldersToUncull = {}
	for _, data in pairs(cullRegions) do
		local minPos = data.minPos
		local maxPos = data.maxPos
		local folder = data.folder
		if isCameraInRegion(minPos, maxPos) then
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
		local startTime = tick()
		cullFolder(folder)
		local endTime = tick()
		if _G.VisTools_InteriorCulling_output then
			_G.out("[VisTools interior culling] Entered cull region: " .. tostring(folder) .. ", took " .. (endTime - startTime) * 1000 .. "ms")
		end
	end
	for folder in pairs(foldersToUncull) do
		local startTime = tick()
		restoreFolderVisibility(folder)
		local endTime = tick()
		if _G.VisTools_InteriorCulling_output then
			_G.out("[VisTools interior culling] Exited cull region: " .. tostring(folder) .. ", took " .. (endTime - startTime) * 1000 .. "ms")
		end	
	end
end

runService.RenderStepped:Connect(function()
	if _G.VisTools_InteriorCulling ~= cullingEnabled then
		cullingEnabled = _G.VisTools_InteriorCulling
		if not cullingEnabled then
			showAllItems()
		end
	end
	if cullingEnabled then
		updateCulling()
	end
end)

setupCullBrushRegions()

_G.out("[OK] VisTools interior culling begun")

local particleEmitters = {} -- {emitter = ParticleEmitter, initialEnabled = bool}

local function collectParticleEmitters()
	for _, descendant in pairs(workspace:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("BasePart") then
			table.insert(particleEmitters, {
				emitter = descendant,
				initialEnabled = descendant.Enabled
			})
		end
	end
end

local function isEmitterIndexed(emitter)
	for _, data in pairs(particleEmitters) do
		if data.emitter == emitter then
			return true
		end
	end
	return false
end

local function handleNewDescendant(descendant)
	if descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("BasePart") then
		if not isEmitterIndexed(descendant) then
			table.insert(particleEmitters, {
				emitter = descendant,
				initialEnabled = descendant.Enabled
			})
		end
	end
end

local function cleanUpEmitters()
	for i = #particleEmitters, 1, -1 do
		local data = particleEmitters[i]
		if data.emitter == nil or data.emitter.Parent == nil then
			if _G.VisTools_ParticleCulling_output then
				_G.out("[VisTools particle culling] Particle emitter " .. i .. " removed because either it or its Parent are nil")
			end
			table.remove(particleEmitters, i)
		end
	end
end

local function updateParticleEmitters()
	if _G.VisTools_ParticleCulling then
		for _, data in pairs(particleEmitters) do
			local particleEmitter = data.emitter
			local basePart = particleEmitter.Parent
			local distance = (basePart.CFrame.Position - camera.CFrame.Position).Magnitude
			particleEmitter.Enabled = distance < PARTICLE_THRESHOLD_DISTANCE
		end
	else
		for _, data in pairs(particleEmitters) do
			data.emitter.Enabled = data.initialEnabled
		end
	end
end


collectParticleEmitters()

coroutine.wrap(function()
	while task.wait(0.1) do
		cleanUpEmitters()
		updateParticleEmitters()
	end
end)()

workspace.DescendantAdded:Connect(handleNewDescendant)

_G.out("[OK] VisTools tree impostor loop begun")
_G.out("[OK] VisTools particle culling begun")
_G.out("[OK] All VisTools systems operational")