local DEV_MODE = false

local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Luatri"):WaitForChild("services"))
local txt = require(svc.replicatedStorage.locales.en_US)
local tsi = require(svc.replicatedStorage.tweeninfos)
local msg = require(svc.replicatedStorage.output)
local cfg = require(svc.replicatedStorage.luatri_config)
local states = require(svc.replicatedStorage.states)

local player = svc.players.LocalPlayer

local dGUI = player.PlayerGui:WaitForChild("DevUI")

local outputframe = dGUI.ScreenSizeFrame.Output

function tween(inst, tweeninfo, propTable)
	svc.tween:Create(inst, tweeninfo, propTable):Play() -- dont ask.
end

function devmode(state: boolean)
	if state ~= DEV_MODE then
		dGUI.Enabled = state
		DEV_MODE = state
		msg.out("DEV_MODE: " .. tostring(state), 5, "output", outputframe)
	end
end

if svc.run:IsStudio() or game.PlaceId == 87531394511191 then -- TODO: figure out a way for people to easily put themselves in a devtable or something like that
	svc.userInput.InputBegan:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.RightControl then
			devmode(not DEV_MODE)
		end
	end)
end

-- DevTools

local dtShown = true

local dtFrame = dGUI.ScreenSizeFrame.Devtools
local dtContainer = dtFrame.Container
local left = dtContainer.leftScroller
local right = dtContainer.rightScroller

local dtToggleButtonTemplate = left.toggleButtonContainer
local dtMomentaryButtonTemplate = left.momentaryButtonContainer
local dtDividerTemplate = left.CatDivider
local dtCloseButton = dtFrame.Titlebar.Close
local dtPopoutButton = dGUI.ScreenSizeFrame.DevtoolsButton




dtToggleButtonTemplate.Parent = nil
dtMomentaryButtonTemplate.Parent = nil
dtDividerTemplate.Parent = nil

local function c3ToRGB(c3: Color3): { R: number, G: number, B: number }
	return {
		R = math.floor(c3.R * 255),
		G = math.floor(c3.G * 255),
		B = math.floor(c3.B * 255),
	}
end

local originalcolor = dtMomentaryButtonTemplate.Click.BackgroundColor3
local ogcolortoRGB = c3ToRGB(originalcolor)
local dimBy = 6
local dimmedcolor = Color3.fromRGB(
	math.clamp(ogcolortoRGB.R - dimBy, 0, 255),
	math.clamp(ogcolortoRGB.G - dimBy, 0, 255),
	math.clamp(ogcolortoRGB.B - dimBy, 0, 255)
)

function dtDivider(text, parent)
	local div = dtDividerTemplate:Clone()
	div.Label.Text = text
	div.Parent = parent
end

function dtToggleButton(text, tooltip, sliderState, parent, call)
	local button = dtToggleButtonTemplate:Clone()
	local sState = sliderState
	button.Click.Label.Text = text
	button.TooltipContainer.Tooltip.Text = tooltip
	if not sState then
		button.Click.sliderContainer.Slider.sliderAccent.Position = UDim2.fromScale(0.25, 0.5)
	else
		button.Click.sliderContainer.Slider.sliderAccent.Position = UDim2.fromScale(0.75, 0.5)
	end
	button.Click.MouseEnter:Connect(function()
		tween(button.Click, tsi.expo02out, { BackgroundColor3 = dimmedcolor }) --cth
		tween(
			button.Click.sliderContainer.Slider.strokeHelper.UIStroke,
			tsi.expo02out,
			{ Color = dimmedcolor } -- cth
		)
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(
				button.TooltipContainer,
				tsi.expo02out,
				{ BackgroundTransparency = 0, Position = UDim2.fromScale(0, 0.5) }
			)
			tween(
				button.TooltipContainer.Tooltip,
				tsi.expo02out,
				{ BackgroundTransparency = 0, TextTransparency = 0, Position = UDim2.fromScale(0, 0.5) }
			)
		end
	end)
	button.Click.MouseLeave:Connect(function()
		tween(button.Click.sliderContainer.Slider.strokeHelper.UIStroke, tsi.expo02out, { Color = originalcolor })
		tween(button.Click, tsi.expo02out, { BackgroundColor3 = originalcolor }) --cth
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(
				button.TooltipContainer,
				tsi.expo02out,
				{ BackgroundTransparency = 1, Position = UDim2.fromScale(0, 1) }
			)
			tween(
				button.TooltipContainer.Tooltip,
				tsi.expo02out,
				{ BackgroundTransparency = 1, TextTransparency = 1, Position = UDim2.fromScale(0, 1) }
			)
		end
	end)
	button.Click.MouseButton1Click:Connect(function()
		if sState then
			sState = false
			tween(
				button.Click.sliderContainer.Slider.sliderAccent,
				tsi.expo02out,
				{ Position = UDim2.fromScale(0.25, 0.5) }
			)
		else
			sState = true
			tween(
				button.Click.sliderContainer.Slider.sliderAccent,
				tsi.expo02out,
				{ Position = UDim2.fromScale(0.75, 0.5) }
			)
		end
		call()
	end)
	button.Parent = parent
end

function dtMomentaryButton(text, tooltip, parent, call)
	local button = dtMomentaryButtonTemplate:Clone()
	button.Click.Label.Text = text
	button.TooltipContainer.Tooltip.Text = tooltip
	button.Click.MouseEnter:Connect(function()
		tween(button.Click, tsi.expo02out, { BackgroundColor3 = dimmedcolor }) --cth
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(
				button.TooltipContainer,
				tsi.expo02out,
				{ BackgroundTransparency = 0, Position = UDim2.fromScale(0, 0.5) }
			)
			tween(
				button.TooltipContainer.Tooltip,
				tsi.expo02out,
				{ BackgroundTransparency = 0, TextTransparency = 0, Position = UDim2.fromScale(0, 0.5) }
			)
		end
	end)
	button.Click.MouseLeave:Connect(function()
		tween(button.Click, tsi.expo02out, { BackgroundColor3 = originalcolor }) --cth
		if button.TooltipContainer.Tooltip.Text ~= "" then
			tween(
				button.TooltipContainer,
				tsi.expo02out,
				{ BackgroundTransparency = 1, Position = UDim2.fromScale(0, 1) }
			)
			tween(
				button.TooltipContainer.Tooltip,
				tsi.expo02out,
				{ BackgroundTransparency = 1, TextTransparency = 1, Position = UDim2.fromScale(0, 1) }
			)
		end
	end)
	button.Click.MouseButton1Click:Connect(call)
	button.Parent = parent
end

function toggleDevtoolsVisibility()
	if not dtShown then
		dtShown = true
		tween(dtFrame, tsi.back05out, { Size = UDim2.fromScale(0.6, 0.6), GroupTransparency = 0 })
		tween(dtFrame.UIStroke, tsi.expo02out, { Transparency = 0 })
	else
		dtShown = false
		tween(dtFrame, tsi.expo05out, { Size = UDim2.fromScale(0.59, 0.59), GroupTransparency = 1 })
		tween(dtFrame.UIStroke, tsi.expo02out, { Transparency = 1 })
	end
	left.Visible = dtShown
	right.Visible = dtShown
	dtCloseButton.Visible = dtShown
	right.Visible = dtShown
end

dtPopoutButton.MouseEnter:Connect(function() -- wtf is this
	tween(dtPopoutButton, tsi.expo05out, { BackgroundTransparency = 0, ImageTransparency = 0 })
end)
dtPopoutButton.MouseLeave:Connect(function()
	tween(dtPopoutButton, tsi.expo05out, { BackgroundTransparency = 0.5, ImageTransparency = 0.5 })
end)
dtCloseButton.MouseEnter:Connect(function()
	tween(
		dtCloseButton,
		tsi.expo05out,
		{ BackgroundColor3 = Color3.fromRGB(232, 17, 35), TextColor3 = Color3.fromRGB(255, 255, 255) }
	)
end)
dtCloseButton.MouseLeave:Connect(function()
	tween(
		dtCloseButton,
		tsi.expo05out,
		{ BackgroundColor3 = Color3.fromRGB(45, 45, 45), TextColor3 = Color3.fromRGB(91, 91, 91) }
	)
end)
dtCloseButton.MouseButton1Down:Connect(function()
	tween(dtCloseButton, tsi.expo05out, { Size = UDim2.fromOffset(18, 18) })
end)
dtCloseButton.MouseButton1Up:Connect(function()
	tween(dtCloseButton, tsi.back05out, { Size = UDim2.fromOffset(21, 21) })
	toggleDevtoolsVisibility()
end)
dtPopoutButton.MouseButton1Down:Connect(function()
	tween(dtPopoutButton, tsi.expo05out, { Size = UDim2.fromOffset(23, 23) })
end)
dtPopoutButton.MouseButton1Up:Connect(function()
	tween(dtPopoutButton, tsi.back05out, { Size = UDim2.fromOffset(26, 26) })
	toggleDevtoolsVisibility()
end)

-- YOU CAN APPEND YOUR FUNCTIONS HERE AS YOU WISH

dtDivider(txt.Luatri, left)

dtToggleButton(txt.ParticleCulling, "", cfg.ParticleCulling, left, function()
	cfg.ParticleCulling = not cfg.ParticleCulling
end)
dtToggleButton(txt.InteriorCulling, "", cfg.InteriorCulling, left, function()
	cfg.InteriorCulling = not cfg.InteriorCulling
end)

dtDivider(txt.DebugOutputs, left)

dtToggleButton(txt.OutputLuatriParticles, "", cfg.ParticleCulling_output, left, function()
	cfg.ParticleCulling_output = not cfg.ParticleCulling_output
end)
dtToggleButton(txt.OutputLuatriInterior, "", cfg.InteriorCulling_output, left, function()
	cfg.InteriorCulling_output = not cfg.InteriorCulling_output
end)
dtToggleButton(txt.OutputLuatriInteriorVerbose, "", cfg.InteriorCulling_verboseOutput, left, function()
	cfg.InteriorCulling_verboseOutput = not cfg.InteriorCulling_verboseOutput
end)

dtDivider(txt.SampleButtons, right)
dtMomentaryButton(txt.SampleButtonTitle, txt.SampleButtonTooltip, right, function()
	msg.out("meow",5,"output",outputframe)
end)
dtDivider(txt.TestOutputs, right)

dtMomentaryButton(txt.NormalOutputTitle,txt.NormalOutputTooltip, right, function()
	msg.out("Hello! This is a test output! " .. math.random(1, 2000), 5, "output", outputframe)
end)

dtMomentaryButton(txt.WarnOutputTitle, txt.WarnOutputTooltip, right, function()
	msg.throw(1, "warn", outputframe)
	msg.throw(2, "warn", outputframe)
end)
dtMomentaryButton(txt.ErrorOutputTitle, txt.ErrorOutputTooltip, right, function()
	msg.throw(1, "error", outputframe)
	msg.throw(2, "error", outputframe)
	msg.throw(3, "error", outputframe)
	msg.throw(9008, "error", outputframe)
end)

toggleDevtoolsVisibility()
states.GUIControllerLoaded = true
states._GUIControllerLoadedBindable:Fire()