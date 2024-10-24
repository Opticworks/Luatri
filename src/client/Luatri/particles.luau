
local particles = {}


local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)
local msg = require(svc.replicatedStorage.output)


local particleEmitters = {}
local emitterLookup = {}

function particles.collectParticleEmitters()
	for _, descendant in pairs(workspace:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("BasePart") then
			table.insert(particleEmitters, {
				emitter = descendant,
				initialEnabled = descendant.Enabled,
			})
		end
	end
end

function particles.addEmitter(emitter, initialEnabled)
	particleEmitters[#particleEmitters + 1] = { emitter = emitter, initialEnabled = initialEnabled }
	emitterLookup[emitter] = true
end

function particles.removeEmitter(emitter)
	for i, data in ipairs(particleEmitters) do
		if data.emitter == emitter then
			table.remove(particleEmitters, i)
			break
		end
	end
	emitterLookup[emitter] = nil
end

function particles.isEmitterIndexed(emitter)
	return emitterLookup[emitter] or false
end

function particles.handleNewDescendant(descendant)
	if descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("BasePart") then
		if not particles.isEmitterIndexed(descendant) then
			particles.addEmitter(descendant, descendant.Enabled)
		end
	end
end

function particles.cleanUpEmitters()
	for i = #particleEmitters, 1, -1 do
		local data = particleEmitters[i]
		if data.emitter == nil or data.emitter.Parent == nil then
			if cfg.ParticleCulling_output then
				msg.out(
					"[luatri particle culling] Particle emitter "
						.. i
						.. " removed because either it or its Parent are nil",
					5,
					"output"
				)
			end
			particles.removeEmitter(data.emitter)
		end
	end
end

function particles.updateParticleEmitters()
	if cfg.ParticleCulling then
		for _, data in pairs(particleEmitters) do
			local particleEmitter = data.emitter
			local basePart = particleEmitter.Parent
			local distance = (basePart.CFrame.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
			particleEmitter.Enabled = distance < cfg.PARTICLE_CULLING_RANGE
		end
	else
		for _, data in pairs(particleEmitters) do
			data.emitter.Enabled = data.initialEnabled
		end
	end
end

particles.collectParticleEmitters()



function particles.onHeartbeat()
		particles.cleanUpEmitters()
		particles.updateParticleEmitters()
end

workspace.DescendantAdded:Connect(particles.handleNewDescendant)


return particles