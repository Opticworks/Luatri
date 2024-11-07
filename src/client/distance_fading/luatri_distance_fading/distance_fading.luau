local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local cfg = require(svc.replicatedStorage.luatri_config)
local msg = require(svc.replicatedStorage.output)
local wrn = require(svc.replicatedStorage.warns)
local obj = require(svc.replicatedStorage.objectfuncs)

local fader = {}

local details = {}
local lastCell = nil
local pendingUpdate = true
local updating = false


function collectDescendantTransparencies(thing)
	local transparencyTable = {}
	for _, descendant in pairs(thing:GetDescendants()) do
		if obj.canSetTransparency(descendant) then
			transparencyTable[descendant] = descendant.Transparency
		end
	end
	return transparencyTable
end

local cullDistances = {
	[1] = cfg.DISTANCE_FADING_RANGE_SMALL,
	[2] = cfg.DISTANCE_FADING_RANGE_MEDIUM,
	[3] = cfg.DISTANCE_FADING_RANGE_LARGE,
	[4] = cfg.DISTANCE_FADING_RANGE_ULTRA
}

function fader.AddDetail(instance,level)
	task.spawn(function()
		local record = {}
		record.cullDistance = cullDistances[level] or cfg.DISTANCE_FADING_RANGE_SMALL
		if obj.canSetTransparency(instance) then
			record.originalTransparency = instance.Transparency
			record.descendantTransparencies = collectDescendantTransparencies(instance)
		else
			record.originalTransparency = 0
			record.descendantTransparencies = {}
		end
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
	local tags = {
		["Detail_Small"] = 1,
		["Detail_Medium"] = 2,
		["Detail_Large"] = 3,
		["Detail_Ultra"] = 4,
	}
	local function addDetail(instance, detailLevel)
		fader.AddDetail(instance, detailLevel)
	end
	for tag, detailLevel in pairs(tags) do
		svc.collection:GetInstanceAddedSignal(tag):Connect(function(instance)
			addDetail(instance, detailLevel)
		end)
		for _, instance in svc.collection:GetTagged(tag) do
			addDetail(instance, detailLevel)
		end
	end
	task.desynchronize()
end

function fader.onHeartbeat()
	debug.profilebegin("distance_fading.fader.onHeartbeat")
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
				if not cfg.SERIAL_MODE then
					task.synchronize()
				end
					if mag < record.cullDistance and not record.visible then
						coroutine.wrap(function()
							record.instance.Parent = record.parent
							record.visible = true
							if cfg.DISTANCE_FADING_TWEEN then
								if cfg.DISTANCE_FADING_TWEEN then
								for v,val in record.descendantTransparencies do 
									print("descendant of something idk")
									print(v,val)
									svc.tween:Create(v, TweenInfo.new(cfg.DISTANCE_FADING_TIME), {Transparency = val}):Play()
								end
								if obj.canSetTransparency(record.instance) then
									print("record instance")
									print(record.originalTransparency)
									svc.tween:Create(record.instance, TweenInfo.new(cfg.DISTANCE_FADING_TIME), {Transparency = record.originalTransparency}):Play()
										task.wait(cfg.DISTANCE_FADING_TIME)
								end
							end
							end
						end)()
						continue
					end
					if mag >= record.cullDistance and record.visible then
						coroutine.wrap(function()
							obj.tweenModelTransparency(record.instance, 1)
							task.wait(cfg.DISTANCE_FADING_TIME)
							record.instance.Parent = nil
							record.visible = false
						end)()
					end
				if not cfg.SERIAL_MODE then
					task.desynchronize()
				end
				counter += 1
				if counter > 50 then
					task.wait()
					counter = 0
				end
			end
			updating = false
		end)
	end
	debug.profileend()
end
return fader
