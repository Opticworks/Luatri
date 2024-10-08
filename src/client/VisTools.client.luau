
_G.VisTools_InteriorCulling = true
_G.VisTools_ParticleCulling = true
_G.VisTools_TreeImpostors = true
_G.VisTools_TreeImpostors_output = false
_G.VisTools_InteriorCulling_output = false
_G.VisTools_ParticleCulling_output = false

-- Configuration

local PARTICLE_THRESHOLD_DISTANCE = 300
local TREE_THRESHOLD_DISTANCE = 550
local TREE_CHECK_INTERVAL = 0.1
local TREE_BATCH_SIZE = 15


local camera = game:GetService("Workspace").CurrentCamera

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
				_G.out("[VisTools ] Particle emitter " .. i .. " removed because either it or its Parent are nil")
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

workspace.DescendantAdded:Connect(handleNewDescendant)

collectParticleEmitters()
coroutine.wrap(function()
	while task.wait(0.1) do
		cleanUpEmitters()
		updateParticleEmitters()
	end
end)()
task.wait(1)

_G.out("[OK] VisTools particle culling begun")
