local message = {}

local svc = require(script.Parent.services)
local tsi = require(script.Parent.tweeninfos)

local outputSample = Instance.new("TextLabel")

outputSample.Font = Enum.Font.Code
outputSample.RichText = true
outputSample.Text = ""
outputSample.TextColor3 = Color3.fromRGB(255, 255, 255)
outputSample.TextSize = 10
outputSample.AnchorPoint = Vector2.new(0, 1)
outputSample.AutomaticSize = Enum.AutomaticSize.XY
outputSample.TextXAlignment = Enum.TextXAlignment.Left 
outputSample.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
outputSample.BorderColor3 = Color3.fromRGB(0, 0, 0)
outputSample.BorderSizePixel = 0
outputSample.Position = UDim2.new(0, 0, 1, 0)
outputSample.Size = UDim2.new(0, 0, 0, 13)
outputSample.Name = "OutputSample"

local function tween(i,t,p)
    svc.tween:Create(i,t,p):Play()
end

function message.out(msg: string, timeout: number, type: string, parent)
	local color
	local color2
	if not timeout then
		timeout = 5
	end
	if type == "error" then
		color = Color3.fromRGB(127,0,0)
		color2 = Color3.fromRGB(255,255,255)
		warn(msg)
	elseif type == "warn" then
		color = Color3.fromRGB(179, 179, 0)
		color2 = Color3.fromRGB(0, 0, 0)
		warn(msg)
	elseif type == "info" then
		color = Color3.fromRGB(0,0,0)
		color2 = Color3.fromRGB(0, 60, 255)
		print(msg)
	else type = "output"
		color = Color3.fromRGB(0, 0, 0)
		color2 = Color3.fromRGB(255, 255, 255)
		print(msg)
	end
	coroutine.wrap(function()
		local output = outputSample:Clone()
		output.Text = msg
		output.Parent = parent
		tween(output, tsi.expo02out, { BackgroundColor3 = color, TextColor3 = color2})
		task.wait(timeout)
		tween(output, TweenInfo.new(timeout / 2), { BackgroundTransparency = 1, TextTransparency = 1 })
		task.wait(timeout / 2)
		output:Destroy()
	end)()
end

return message