--!nocheck

-- TODO: this all needs a huge rewrite.

_G.VisTools_InteriorCulling = true
_G.VisTools_ParticleCulling = true
_G.VisTools_TreeImpostors = true
_G.VisTools_TreeImpostors_output = false
_G.VisTools_TreeImpostors_batch_output = true
_G.VisTools_InteriorCulling_output = true
_G.VisTools_ParticleCulling_output = false
_G.VisTools_DistanceFading = true
_G.VisTools_DistanceFading_output = true

repeat
	task.wait()
until _G.GUIControllerLoaded

local runService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

-- Configuration

local PARTICLE_CULLING_RANGE = 300
local TREE_IMPOSTOR_RANGE = 200
local DISTANCE_FADING_BEGIN = 600 -- for distance fading
local DISTANCE_FADING_END = 1200

-- Interior culling

local camera = workspace.CurrentCamera
local interiorFolder = workspace:WaitForChild("Interiors") -- Find another way to do this; this will yield the rest of the script if not found!

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
				part = cullBrush,
			})
		else
			if folder then
				_G.out("<b>[VisTools warning]</b> Cull brush not found or invalid for folder: " .. folder.Name)
			else
				_G.out("<b>[VisTools warning]</b> Cull brush not found or invalid for an unknown folder")
			end
		end
	end
end

local function isCameraInRegion(minPos, maxPos) -- todo: get rid of this crap
	local camPos = camera.CFrame.Position
	return camPos.X >= minPos.X
		and camPos.X <= maxPos.X
		and camPos.Y >= minPos.Y
		and camPos.Y <= maxPos.Y
		and camPos.Z >= minPos.Z
		and camPos.Z <= maxPos.Z
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
			_G.out(
				"[VisTools interior culling] Entered cull region: "
					.. tostring(folder)
					.. ", took "
					.. (endTime - startTime) * 1000
					.. "ms"
			)
		end
	end
	for folder in pairs(foldersToUncull) do
		local startTime = tick()
		restoreFolderVisibility(folder)
		local endTime = tick()
		if _G.VisTools_InteriorCulling_output then
			_G.out(
				"[VisTools interior culling] Exited cull region: "
					.. tostring(folder)
					.. ", took "
					.. (endTime - startTime) * 1000
					.. "ms"
			)
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

-- tree impostors
-- I stole this code from Cardboard Box Simulator, an example project made by MrChickenRocket
-- thank you so much for making it open-source :)

local details = {}
local lastCell = nil
local pendingUpdate = true
local updating = false

function AddDetail(instance)
	task.spawn(function()
		local record = {}
		record.cullDistance = TREE_IMPOSTOR_RANGE
		record.instance = instance
		record.primaryPart = instance
		record.visible = true
		record.parent = instance.Parent
		if instance:IsA("Folder") then
			while true do
				record.primaryPart = instance:FindFirstChildWhichIsA("BasePart", true)
				if record.primaryPart == nil then
					wait()
				else
					break
				end
			end
		end

		if instance:IsA("Model") then
			while true do
				record.primaryPart = instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
				if record.primaryPart == nil then
					wait()
				else
					break
				end
			end
		end

		if record.primaryPart == nil then
			_G.out("[temp] Missing PrimaryPart for " .. instance.Name)
			return
		end

		local dist = record.instance:GetAttribute("distance")
		if dist ~= nil then
			record.cullDistance = dist
		end

		details[instance] = record
	end)
end

function Setup()
	CollectionService:GetInstanceAddedSignal("Detail_Small"):Connect(function(instance)
		AddDetail(instance)
	end)
	for _, instance in CollectionService:GetTagged("Detail_Small") do
		AddDetail(instance)
	end
end
Setup()

runService.Heartbeat:Connect(function(dt)
	local pos = camera.CFrame.Position
	local cellSize = 4
	local cell = pos // cellSize
	if cell ~= lastCell then
		lastCell = cell
		pendingUpdate = true
	end
	if pendingUpdate and not updating then
		updating = true
		pendingUpdate = false
		task.spawn(function()
			local counter = 0
			for _, record in details do
				local vec = record.primaryPart.Position - pos
				local mag = vec.Magnitude
				local lod = record.parent.parent:WaitForChild("LOD")
				if mag < record.cullDistance and not record.visible then
					record.instance.Parent = record.parent
					if lod and lod.Visible then -- it was fine yesterday, wtf is up today???
						lod.Visible = false
					end
					record.visible = true
					continue
				end
				if mag >= record.cullDistance and record.visible then
					record.instance.Parent = nil
					if lod and lod.Visible then
						lod.Visible = true
					end
					record.visible = false
				end
				counter += 1
				if counter > 50 then
					wait()
					counter = 0
				end
			end
			updating = false
		end)
	end
end)

local particleEmitters = {}
local emitterLookup = {}

local function collectParticleEmitters()
	for _, descendant in pairs(workspace:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("BasePart") then
			table.insert(particleEmitters, {
				emitter = descendant,
				initialEnabled = descendant.Enabled,
			})
		end
	end
end

local function addEmitter(emitter, initialEnabled)
	particleEmitters[#particleEmitters + 1] = { emitter = emitter, initialEnabled = initialEnabled }
	emitterLookup[emitter] = true
end

local function removeEmitter(emitter)
	for i, data in ipairs(particleEmitters) do
		if data.emitter == emitter then
			table.remove(particleEmitters, i)
			break
		end
	end
	emitterLookup[emitter] = nil
end

local function isEmitterIndexed(emitter)
	return emitterLookup[emitter] or false
end

local function handleNewDescendant(descendant)
	if descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("BasePart") then
		if not isEmitterIndexed(descendant) then
			addEmitter(descendant, descendant.Enabled)
		end
	end
end

local function cleanUpEmitters()
	for i = #particleEmitters, 1, -1 do
		local data = particleEmitters[i]
		if data.emitter == nil or data.emitter.Parent == nil then
			if _G.VisTools_ParticleCulling_output then
				_G.out(
					"[VisTools particle culling] Particle emitter "
						.. i
						.. " removed because either it or its Parent are nil"
				)
			end
			removeEmitter(data.emitter)
		end
	end
end

local function updateParticleEmitters()
	if _G.VisTools_ParticleCulling then
		for _, data in pairs(particleEmitters) do
			local particleEmitter = data.emitter
			local basePart = particleEmitter.Parent
			local distance = (basePart.CFrame.Position - camera.CFrame.Position).Magnitude
			particleEmitter.Enabled = distance < PARTICLE_CULLING_RANGE
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
