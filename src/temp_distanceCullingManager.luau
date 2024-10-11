-- I stole this code from Cardboard Box Simulator, an example project made by MrChickenRocket
-- thank you so much for making it open-source :)

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local details = {}
local lastCell = nil
local pendingUpdate = true
local updating = false

function AddDetail(instance)
	task.spawn(function()
		local record = {}
		record.cullDistance = 300
		record.instance = instance
		record.primaryPart = instance
		record.visible = true 
		record.parent = instance.Parent
		if (instance:IsA("Folder")) then
			while true  do
				record.primaryPart = instance:FindFirstChildWhichIsA("BasePart", true)
				if (record.primaryPart == nil) then
					wait()
				else
					break
				end
			end
		end
		
		if (instance:IsA("Model")) then
			while(true) do
				record.primaryPart = instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
				if (record.primaryPart == nil) then
					wait()
				else
					break
				end
			end
		end
		
		if (record.primaryPart == nil) then
			_G.out("[temp] Missing PrimaryPart for " .. instance.Name)
			return
		end
			
		local dist = record.instance:GetAttribute("distance")
		if (dist ~= nil) then
			record.cullDistance = dist
		end
			
		details[instance] = record
	end)
	
end

function Setup()
	CollectionService:GetInstanceAddedSignal("Detail_Small"):Connect(function(instance)
		AddDetail(instance)
	end)
	for key,instance in CollectionService:GetTagged("Detail_Small") do
		AddDetail(instance)
	end
end
Setup()

RunService.Heartbeat:Connect(function(dt)
	local player = game.Players.LocalPlayer
	local character = player.Character
	if (character == nil or character.PrimaryPart == nil) then
		return
	end
	local pos = character.PrimaryPart.Position
	local cellSize = 4
	local cell = pos // cellSize
	if (cell ~= lastCell) then
		lastCell = cell
		pendingUpdate = true
	end

	if (pendingUpdate and (not updating)) then
		updating = true
		pendingUpdate = false
		task.spawn(function()
			
			local counter = 0
			for _,record in details do
				local vec = record.primaryPart.Position - pos
				local mag = vec.Magnitude
				if (mag < record.cullDistance and (not record.visible)) then
					record.instance.Parent = record.parent
					record.visible = true
					continue
				end
				if (mag >= record.cullDistance and (record.visible)) then
					record.instance.Parent = nil
					record.visible = false
				end
				counter+=1
				if (counter > 50) then
					wait()
					counter =0
				end
			end
			updating = false
		end)
	end
end)
