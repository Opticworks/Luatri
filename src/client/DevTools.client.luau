repeat task.wait() until _G.convertedGUILoaded

local player = game:GetService("Players").LocalPlayer
local dGUI = player.PlayerGui:WaitForChild("DevUI")

local outputframe = dGUI.ScreenSizeFrame.Output
local outputSample = outputframe.OutputSample

local tsi = {
	expo1out  = TweenInfo.new(1,  Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),
	expo02out = TweenInfo.new(0.2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),
	expo05out = TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),
	back05out = TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
}


outputSample.Parent = nil

function tween(inst,tsi,propTable)
	game:GetService("TweenService"):Create(inst,tsi,propTable):Play() --[[
     I made this function just so that stuff would look nicer. 
	 It's also a lot easier to just type 5 letters than ts:create(whatever,whatever,whatever):Play().
	 Yes I'm lazy.
	]]
end

function _G.out(message:string,timeout)
	if not timeout then timeout = 5 end -- trying differently gave me some computer magic error
	coroutine.wrap(function()
		print(message)
		local output = outputSample:Clone()
		output.Parent = outputframe
		tween(output,tsi.expo02out,{BackgroundColor3 = Color3.fromRGB(0,0,0)})
		task.wait(timeout)
		tween(output,TweenInfo.new(timeout / 2),{BackgroundTransparency = 1,TextTransparency = 1})
		task.wait(timeout / 2)
		output:Destroy()
	end)()
end

function devmode(state: boolean)
	if state ~= DEV_MODE then
		dGUI.Enabled = state
		DEV_MODE = state
		_G.out("DEV_MODE: " .. tostring(state))
	end
end


--[[ Konami Code
	Don't want the Konami Code? Do you prefer adding your own function that toggles this on or off?
	Just comment out this whole thing, and use devmode(true) or devmode(false) the way you want to, to toggle the UI visibility.
]]

local tKonamiCode = {
	Enum.KeyCode.Up, Enum.KeyCode.Up,
	Enum.KeyCode.Down, Enum.KeyCode.Down,
	Enum.KeyCode.Left, Enum.KeyCode.Right,
	Enum.KeyCode.Left, Enum.KeyCode.Right,
	Enum.KeyCode.B, Enum.KeyCode.A
}; local konamiIndex = 1

local function konamiCode(input)
	if input.KeyCode == tKonamiCode[konamiIndex] then
		konamiIndex = konamiIndex + 1
		if konamiIndex > #tKonamiCode then
			devmode((not DEV_MODE))
			konamiIndex = 1
		end
	else
		konamiIndex = 1
	end
end


-- DevTools

local dtShown = false

local dtFrame = dGUI.ScreenSizeFrame.Devtools
local dtContainer = dtFrame.Container
local dtLeftScrollframe = dtContainer.leftScroller
local dtRightScrollframe = dtContainer.rightScroller

local dtToggleButtonTemplate = dtLeftScrollframe.toggleButtonContainer
local dtMomentaryButtonTemplate = dtLeftScrollframe.momentaryButtonContainer
local dtDividerTemplate = dtLeftScrollframe.CatDivider
local dtCloseButton = dtFrame.Titlebar.Close
local dtPopoutButton = dGUI.ScreenSizeFrame.DevtoolsButton

dtToggleButtonTemplate.Parent = nil
dtMomentaryButtonTemplate.Parent = nil
dtDividerTemplate.Parent = nil

function dtDivider(text,parent)
	local div = dtDividerTemplate:Clone()
	div.Label.Text = text
	div.Parent = parent
end

function dtToggleButton(text,tooltip,sliderState,parent,call)
	local button = dtToggleButtonTemplate:Clone()
	local sState = sliderState -- fuck my life
	button.Click.Label.Text = text
	button.TooltipContainer.Tooltip.Text = tooltip
	if not sState then
		button.Click.sliderContainer.Slider.sliderAccent.Position = UDim2.fromScale(0.25,0.5)
	else 
		button.Click.sliderContainer.Slider.sliderAccent.Position = UDim2.fromScale(0.75,0.5)
	end
	button.Click.MouseEnter:Connect(function()
		tween(button.Click,tsi.expo02out,{BackgroundColor3 = Color3.fromRGB(20,20,20)})
		tween(button.Click.sliderContainer.Slider.strokeHelper.UIStroke,tsi.expo02out,{Color = Color3.fromRGB(20,20,20)})
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(button.TooltipContainer,tsi.expo02out,{BackgroundTransparency = 0,Position = UDim2.fromScale(0,0.5)})
			tween(button.TooltipContainer.Tooltip,tsi.expo02out,{BackgroundTransparency = 0, TextTransparency = 0,Position = UDim2.fromScale(0,0.5)})
		end
	end)
	button.Click.MouseLeave:Connect(function()
		tween(button.Click.sliderContainer.Slider.strokeHelper.UIStroke,tsi.expo02out,{Color = Color3.fromRGB(28,28,28)})
		tween(button.Click,tsi.expo02out,{BackgroundColor3 = Color3.fromRGB(28,28,28)})
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(button.TooltipContainer,tsi.expo02out,{BackgroundTransparency = 1,Position = UDim2.fromScale(0,1)})
			tween(button.TooltipContainer.Tooltip,tsi.expo02out,{BackgroundTransparency = 1, TextTransparency = 1,Position = UDim2.fromScale(0,1)})
		end
	end)
	button.Click.MouseButton1Click:Connect(function()
		if sState then
			sState = false
			tween(button.Click.sliderContainer.Slider.sliderAccent,tsi.expo02out,{Position = UDim2.fromScale(0.25,0.5)})
		else
			sState = true
			tween(button.Click.sliderContainer.Slider.sliderAccent,tsi.expo02out,{Position = UDim2.fromScale(0.75,0.5)})
		end
		call()
	end)
	button.Parent = parent
end

function dtMomentaryButton(text,tooltip,parent,call)
	local button = dtMomentaryButtonTemplate:Clone()
	button.Click.Label.Text = text
	button.TooltipContainer.Tooltip.Text = tooltip
	button.Click.MouseEnter:Connect(function()
		tween(button.Click,tsi.expo02out,{BackgroundColor3 = Color3.fromRGB(20,20,20)})
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(button.TooltipContainer,tsi.expo02out,{BackgroundTransparency = 0,Position = UDim2.fromScale(0,0.5)})
			tween(button.TooltipContainer.Tooltip,tsi.expo02out,{BackgroundTransparency = 0, TextTransparency = 0,Position = UDim2.fromScale(0,0.5)})
		end
	end)
	button.Click.MouseLeave:Connect(function()
		tween(button.Click,tsi.expo02out,{BackgroundColor3 = Color3.fromRGB(28,28,28)})
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(button.TooltipContainer,tsi.expo02out,{BackgroundTransparency = 1,Position = UDim2.fromScale(0,1)})
			tween(button.TooltipContainer.Tooltip,tsi.expo02out,{BackgroundTransparency = 1, TextTransparency = 1,Position = UDim2.fromScale(0,1)})
		end
	end)
	button.Click.MouseButton1Click:Connect(call)
	button.Parent = parent
end

function toggleDevtoolsVisibility()
	if not dtShown then
		dtShown = true
		tween(dtFrame,tsi.back05out,{Size = UDim2.fromScale(0.6,0.6),GroupTransparency = 0})
		tween(dtFrame.UIStroke,tsi.expo02out,{Transparency = 0})

	else
		dtShown = false
		tween(dtFrame,tsi.expo05out,{Size = UDim2.fromScale(0.59,0.59),GroupTransparency = 1})
		tween(dtFrame.UIStroke,tsi.expo02out,{Transparency = 1})
	end
	dtLeftScrollframe.Visible = dtShown
	dtRightScrollframe.Visible = dtShown
	dtCloseButton.Visible = dtShown
	dtRightScrollframe.Visible = dtShown
end

dtPopoutButton.MouseEnter:Connect(function()
	tween(dtPopoutButton,tsi.expo05out,{BackgroundTransparency = 0,ImageTransparency = 0})
end)
dtPopoutButton.MouseLeave:Connect(function()
	tween(dtPopoutButton,tsi.expo05out,{BackgroundTransparency = 0.5,ImageTransparency = 0.5})
end)
dtCloseButton.MouseEnter:Connect(function() 
	tween(dtCloseButton,tsi.expo05out,{BackgroundColor3 = Color3.fromRGB(232,17,35),TextColor3 = Color3.fromRGB(255,255,255)})
end)
dtCloseButton.MouseLeave:Connect(function()
	tween(dtCloseButton,tsi.expo05out,{BackgroundColor3 = Color3.fromRGB(45,45,45),TextColor3 = Color3.fromRGB(91,91,91)})
end)

dtCloseButton.MouseButton1Down:Connect(function()
	tween(dtCloseButton,tsi.expo05out,{Size = UDim2.fromOffset(18,18)})
end)
dtCloseButton.MouseButton1Up:Connect(function()
	tween(dtCloseButton,tsi.back05out,{Size = UDim2.fromOffset(21,21)})
	toggleDevtoolsVisibility()
end)

dtPopoutButton.MouseButton1Down:Connect(function()
	tween(dtPopoutButton,tsi.expo05out,{Size = UDim2.fromOffset(23,23)})
end)
dtPopoutButton.MouseButton1Up:Connect(function()
	tween(dtPopoutButton,tsi.back05out,{Size = UDim2.fromOffset(26,26)})
	toggleDevtoolsVisibility()
end)


_G.DEV_MODE = false

game:GetService("UserInputService").InputBegan:Connect(function(key) -- TODO - delete this
	konamiCode(key)
end)


dtDivider("VISTOOLS",dtLeftScrollframe)

dtToggleButton("Particle Culling","",_G.VisTools_ParticleCulling,dtLeftScrollframe,function() _G.VisTools_ParticleCulling = not _G.VisTools_ParticleCulling end)
dtToggleButton("Interior Culling","",_G.VisTools_InteriorCulling,dtLeftScrollframe,function() _G.VisTools_InteriorCulling = not _G.VisTools_InteriorCulling end)
dtToggleButton("Tree Impostors","",_G.VisTools_TreeImpostors,dtLeftScrollframe,function() _G.VisTools_TreeImpostors = not _G.VisTools_TreeImpostors end)

dtDivider("DEBUG OUTPUTS",dtLeftScrollframe)

dtToggleButton("VisTools tree impostors","",_G.VisTools_TreeImpostors_output,dtLeftScrollframe,function() _G.VisTools_TreeImpostors_output = not _G.VisTools_TreeImpostors_output end)
dtToggleButton("VisTools particle culling","",_G.VisTools_ParticleCulling_output,dtLeftScrollframe,function() _G.VisTools_ParticleCulling_output = not _G.VisTools_ParticleCulling_output end)
dtToggleButton("VisTools interior culling","",_G.VisTools_InteriorCulling_output,dtLeftScrollframe,function() _G.VisTools_InteriorCulling_output = not _G.VisTools_InteriorCulling_output end)
dtToggleButton("VisTools verbose interior culling","",_G.VisTools_InteriorCulling_verboseOutput,dtLeftScrollframe,function() _G.VisTools_InteriorCulling_verboseOutput = not _G.VisTools_InteriorCulling_verboseOutput end)


dtShown = true
toggleDevtoolsVisibility() --[[ Whoops.
 I have to call this function because I left all of the values to if it was visible.
 Here is hoping nobody will notice... teehee :3
]]

_G.GUIControllerLoaded = true