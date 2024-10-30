local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local zonemanager = {}
local zones = {}
local currentZone = nil

--A very simple zone management system
--Zones are flat on the xz axis and defined by the model bounds
--You can only be in one zone at a time, and zones define all the other zones they can see
--Currently invisible zones are deparented
 

function AddZone(instance)
 	local zoneId = instance.Name
	if zones[zoneId] ~= nil then
		return
	end

	local zoneRec = {}
	zoneRec.model = instance
	zoneRec.parent = instance.Parent
	zoneRec.zoneId = zoneId
	zoneRec.visibleZones = {}
 
	zones[zoneId] = zoneRec
 	local str = instance:GetAttribute("Zones")
	if str then
		local split = string.split(str,",")
		for _,value in split do
			local id = value
			table.insert(zoneRec.visibleZones,id) 
		end
	end

end

local function Setup()
	svc.collection:GetInstanceAddedSignal("Zone"):Connect(function(instance)
		AddZone(instance)
	end)
	for _,instance in svc.collection:GetTagged("Zone") do
		AddZone(instance)
	end
end

Setup()

function ZoneChanged()

	--Get the id
	local id = currentZone.Name
	local zoneRec = zones[id]
	if zoneRec == nil then
		return
	end
	
	
	--Loop through and parent all the current zones to the world, and deparent all the rest
	local invisibleZones = {}
	for _,v in zones do
		invisibleZones[zoneRec] = v
	end
	
	for _,index in zoneRec.visibleZones do
		
		local visibleZone = zones[index]
		if visibleZone == nil then
			print("missing zone?", index)
			continue
		end
		visibleZone.model.Parent = zoneRec.parent
		invisibleZones[visibleZone] = nil
	end
	for _,_ in invisibleZones do
		zoneRec.model.Parent = nil
	end
end

function IsWithinZone(position, cf, size)
	-- Convert the global position to local position relative to the bounding box's CFrame
	local localPos = cf:PointToObjectSpace(position)

	-- Check if the local position is within the bounding box's size boundaries on the XZ plane
	local minX = -size.X / 2
	local maxX = size.X / 2
	local minZ = -size.Z / 2
	local maxZ = size.Z / 2

	return localPos.X >= minX and localPos.X <= maxX and localPos.Z >= minZ and localPos.Z <= maxZ
end

function zonemanager.onHeartbeat()

	local player = svc.players.LocalPlayer
	local character = player.Character
	
	if character == nil or character.PrimaryPart == nil then
		return
	end

	local pos = character.PrimaryPart.Position
	local newZone = nil
	for _,value in zones do
		
		if value.PrimaryPart == nil then
			continue
		end
		local cf = value.PrimaryPart.CFrame
		local size = value.PrimaryPart.Size
		if IsWithinZone(pos, cf, size) then
			newZone = value
		end
	end
	
	if newZone then
		if currentZone ~= newZone then
			currentZone = newZone
			ZoneChanged()
		end
	end
end

return zonemanager