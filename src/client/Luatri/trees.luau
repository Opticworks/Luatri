local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)
local msg = require(svc.replicatedStorage.output)
local wrn = require(svc.replicatedStorage.warns)
local state = require(svc.replicatedStorage.states)

local tree = {}

local details = {}
local lastCell = nil
local pendingUpdate = true
local updating = false

function tree.AddDetail(instance)
	task.spawn(function()
		local record = {}
		record.cullDistance = cfg.TREE_IMPOSTOR_RANGE
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
			msg.throw(wrn[4], "warn")
			return
		end
		record.lod = instance.parent.parent:WaitForChild("LOD", math.huge)
		local dist = record.instance:GetAttribute("distance")
		if dist ~= nil then
			record.cullDistance = dist
		end
		details[instance] = record
	end)
end

function tree.setup()
	task.synchronize()
	svc.collection:GetInstanceAddedSignal("Detail_Small"):Connect(function(instance)
		tree.AddDetail(instance)
	end)
	for _, instance in svc.collection:GetTagged("Detail_Small") do
		tree.AddDetail(instance)
	end
	task.desynchronize()
end

function tree.onHeartbeat()
	
	local cellSize = 4
	local cell = state.camPos // cellSize
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
				local vec = record.primaryPart.Position - state.camPos
				local mag = vec.Magnitude
				task.synchronize()
					if mag < record.cullDistance and not record.visible then
						record.instance.Parent = record.parent
						record.lod.Parent = nil
						record.visible = true
						continue
					end
					if mag >= record.cullDistance and record.visible then
						record.instance.Parent = nil
						record.lod.Parent = record.parent
						record.visible = false
					end
				task.desynchronize()
				counter += 1
				if counter > 50 then
					wait()
					counter = 0
				end
			end
			updating = false
		end)
	end
end

return tree
