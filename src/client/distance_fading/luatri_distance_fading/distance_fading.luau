local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)
local msg = require(svc.replicatedStorage.output)
local wrn = require(svc.replicatedStorage.warns)

local fader = {}

local details = {}
local lastCell = nil
local pendingUpdate = true
local updating = false

function fader.AddDetail(instance)
	task.spawn(function()
		local record = {}
		record.cullDistance = cfg.DISTANCE_FADING_RANGE
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
		local dist = record.instance:GetAttribute("distance")
		if dist ~= nil then
			record.cullDistance = dist
		end
		details[instance] = record
	end)
end

function fader.setup()
	task.synchronize()
	svc.collection:GetInstanceAddedSignal("Detail_Small"):Connect(function(instance)
		fader.AddDetail(instance)
	end)
	for _, instance in svc.collection:GetTagged("Detail_Small") do
		fader.AddDetail(instance)
	end
	task.desynchronize()
end

function fader.onHeartbeat()
	local cellSize = 4
	local cell = workspace.CurrentCamera.CFrame.Position // cellSize
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
				local vec = record.primaryPart.Position - workspace.CurrentCamera.CFrame.Position
				local mag = vec.Magnitude
				task.synchronize()
				if svc.run.Heartbeat:Wait() > cfg.MAX_FRAMETIME then
					task.wait() 
				end
					if mag < record.cullDistance and not record.visible then
						record.instance.Parent = record.parent
						record.visible = true
                        print("record is now visible")
						continue
					end
					if mag >= record.cullDistance and record.visible then
						record.instance.Parent = nil
						record.visible = false
                        print("record is now invisible")
					end
				task.desynchronize()
				counter += 1
				if counter > 50 then
					task.wait()
					counter = 0
				end
			end
			updating = false
		end)
	end
end
return fader
