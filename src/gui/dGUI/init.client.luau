--!nocheck

local theme = require(script.theme)
local svc = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("services"))
local states = require(svc.replicatedStorage.states)

local Converted = {
	["_DevUI"] = Instance.new("ScreenGui"),
	["_Grids"] = Instance.new("Frame"),
	["_RuleOfThirds"] = Instance.new("Frame"),
	["_Line"] = Instance.new("Frame"),
	["_Line1"] = Instance.new("Frame"),
	["_Line2"] = Instance.new("Frame"),
	["_Line3"] = Instance.new("Frame"),
	["_Phi"] = Instance.new("Frame"),
	["_Line4"] = Instance.new("Frame"),
	["_Cross"] = Instance.new("Frame"),
	["_Line5"] = Instance.new("Frame"),
	["_Line6"] = Instance.new("Frame"),
	["_Fibonacci"] = Instance.new("Frame"),
	["_Frame"] = Instance.new("Frame"),
	["_UIStroke"] = Instance.new("UIStroke"),
	["_Frame1"] = Instance.new("Frame"),
	["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint"),
	["_UIStroke1"] = Instance.new("UIStroke"),
	["_UICorner"] = Instance.new("UICorner"),
	["_Frame2"] = Instance.new("Frame"),
	["_UIStroke2"] = Instance.new("UIStroke"),
	["_Frame3"] = Instance.new("Frame"),
	["_UIAspectRatioConstraint1"] = Instance.new("UIAspectRatioConstraint"),
	["_UIStroke3"] = Instance.new("UIStroke"),
	["_UICorner1"] = Instance.new("UICorner"),
	["_Frame4"] = Instance.new("Frame"),
	["_UIStroke4"] = Instance.new("UIStroke"),
	["_Frame5"] = Instance.new("Frame"),
	["_UIAspectRatioConstraint2"] = Instance.new("UIAspectRatioConstraint"),
	["_UIStroke5"] = Instance.new("UIStroke"),
	["_UICorner2"] = Instance.new("UICorner"),
	["_Frame6"] = Instance.new("Frame"),
	["_UIStroke6"] = Instance.new("UIStroke"),
	["_Frame7"] = Instance.new("Frame"),
	["_UIAspectRatioConstraint3"] = Instance.new("UIAspectRatioConstraint"),
	["_UIStroke7"] = Instance.new("UIStroke"),
	["_UICorner3"] = Instance.new("UICorner"),
	["_Frame8"] = Instance.new("Frame"),
	["_UIStroke8"] = Instance.new("UIStroke"),
	["_Frame9"] = Instance.new("Frame"),
	["_UIAspectRatioConstraint4"] = Instance.new("UIAspectRatioConstraint"),
	["_UIStroke9"] = Instance.new("UIStroke"),
	["_UICorner4"] = Instance.new("UICorner"),
	["_Frame10"] = Instance.new("Frame"),
	["_UIStroke10"] = Instance.new("UIStroke"),
	["_Frame11"] = Instance.new("Frame"),
	["_UIAspectRatioConstraint5"] = Instance.new("UIAspectRatioConstraint"),
	["_UIStroke11"] = Instance.new("UIStroke"),
	["_UICorner5"] = Instance.new("UICorner"),
	["_Frame12"] = Instance.new("Frame"),
	["_UIStroke12"] = Instance.new("UIStroke"),
	["_ScreenSizeFrame"] = Instance.new("Frame"),
	["_Reminder"] = Instance.new("Frame"),
	["_TextLabel"] = Instance.new("TextLabel"),
	["_ImageLabel"] = Instance.new("ImageLabel"),
	["_UIAspectRatioConstraint6"] = Instance.new("UIAspectRatioConstraint"),
	["_UIListLayout"] = Instance.new("UIListLayout"),
	["_Output"] = Instance.new("Frame"),
	["_UIListLayout1"] = Instance.new("UIListLayout"),
	["_DevtoolsButton"] = Instance.new("ImageButton"),
	["_UICorner6"] = Instance.new("UICorner"),
	["_UIStroke13"] = Instance.new("UIStroke"),
	["_Devtools"] = Instance.new("CanvasGroup"),
	["_UICorner7"] = Instance.new("UICorner"),
	["_UIStroke14"] = Instance.new("UIStroke"),
	["_Titlebar"] = Instance.new("Frame"),
	["_TextLabel1"] = Instance.new("TextLabel"),
	["_ImageLabel1"] = Instance.new("ImageLabel"),
	["_UIAspectRatioConstraint7"] = Instance.new("UIAspectRatioConstraint"),
	["_IGNORE_spacer"] = Instance.new("Frame"),
	["_UICorner8"] = Instance.new("UICorner"),
	["_UIStroke15"] = Instance.new("UIStroke"),
	["_Close"] = Instance.new("TextButton"),
	["_UIAspectRatioConstraint8"] = Instance.new("UIAspectRatioConstraint"),
	["_UICorner9"] = Instance.new("UICorner"),
	["_Container"] = Instance.new("Frame"),
	["_leftScroller"] = Instance.new("ScrollingFrame"),
	["_UIListLayout2"] = Instance.new("UIListLayout"),
	["_CatDivider"] = Instance.new("Frame"),
	["_Label"] = Instance.new("TextLabel"),
	["_UIListLayout3"] = Instance.new("UIListLayout"),
	["_Line7"] = Instance.new("Frame"),
	["_Line8"] = Instance.new("Frame"),
	["_toggleButtonContainer"] = Instance.new("Frame"),
	["_Click"] = Instance.new("TextButton"),
	["_UICorner10"] = Instance.new("UICorner"),
	["_Label1"] = Instance.new("TextLabel"),
	["_sliderContainer"] = Instance.new("Frame"),
	["_Slider"] = Instance.new("Frame"),
	["_UICorner11"] = Instance.new("UICorner"),
	["_UIAspectRatioConstraint9"] = Instance.new("UIAspectRatioConstraint"),
	["_sliderAccent"] = Instance.new("Frame"),
	["_sliderCircle"] = Instance.new("Frame"),
	["_UIAspectRatioConstraint10"] = Instance.new("UIAspectRatioConstraint"),
	["_UICorner12"] = Instance.new("UICorner"),
	["_strokeHelper"] = Instance.new("Frame"),
	["_UIStroke16"] = Instance.new("UIStroke"),
	["_UICorner13"] = Instance.new("UICorner"),
	["_TooltipContainer"] = Instance.new("Frame"),
	["_Tooltip"] = Instance.new("TextLabel"),
	["_UICorner14"] = Instance.new("UICorner"),
	["_momentaryButtonContainer"] = Instance.new("Frame"),
	["_Click1"] = Instance.new("TextButton"),
	["_UICorner15"] = Instance.new("UICorner"),
	["_Label2"] = Instance.new("TextLabel"),
	["_TooltipContainer1"] = Instance.new("Frame"),
	["_Tooltip1"] = Instance.new("TextLabel"),
	["_UICorner16"] = Instance.new("UICorner"),
	["_rightScroller"] = Instance.new("ScrollingFrame"),
	["_UIListLayout4"] = Instance.new("UIListLayout"),
	["_Modal"] = Instance.new("Frame"),
	["_TextLabel2"] = Instance.new("TextLabel"),
	["_Frame13"] = Instance.new("Frame"),
	["_TextLabel3"] = Instance.new("TextLabel"),
}

-- Properties:

Converted["_DevUI"].IgnoreGuiInset = true
Converted["_DevUI"].ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
Converted["_DevUI"].Enabled = false
Converted["_DevUI"].ResetOnSpawn = false
Converted["_DevUI"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Converted["_DevUI"].Name = "DevUI"
Converted["_DevUI"].Parent = game:GetService("Players").LocalPlayer.PlayerGui

Converted["_Grids"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Grids"].BackgroundTransparency = 1
Converted["_Grids"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Grids"].BorderSizePixel = 0
Converted["_Grids"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Grids"].Name = "Grids"
Converted["_Grids"].Parent = Converted["_DevUI"]

Converted["_RuleOfThirds"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_RuleOfThirds"].BackgroundTransparency = 1
Converted["_RuleOfThirds"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_RuleOfThirds"].BorderSizePixel = 0
Converted["_RuleOfThirds"].Size = UDim2.new(1, 0, 1, 0)
Converted["_RuleOfThirds"].Visible = false
Converted["_RuleOfThirds"].Name = "RuleOfThirds"
Converted["_RuleOfThirds"].Parent = Converted["_Grids"]

Converted["_Line"].BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Converted["_Line"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line"].BorderSizePixel = 0
Converted["_Line"].Position = UDim2.new(0, 0, 0.330000013, 0)
Converted["_Line"].Size = UDim2.new(1, 0, 0, 3)
Converted["_Line"].Name = "Line"
Converted["_Line"].Parent = Converted["_RuleOfThirds"]

Converted["_Line1"].BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Converted["_Line1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line1"].BorderSizePixel = 0
Converted["_Line1"].Position = UDim2.new(0.330000013, 0, 0, 0)
Converted["_Line1"].Size = UDim2.new(0, 3, 1, 0)
Converted["_Line1"].Name = "Line"
Converted["_Line1"].Parent = Converted["_RuleOfThirds"]

Converted["_Line2"].BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Converted["_Line2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line2"].BorderSizePixel = 0
Converted["_Line2"].Position = UDim2.new(0.660000026, 0, 0, 0)
Converted["_Line2"].Size = UDim2.new(0, 3, 1, 0)
Converted["_Line2"].Name = "Line"
Converted["_Line2"].Parent = Converted["_RuleOfThirds"]

Converted["_Line3"].BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Converted["_Line3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line3"].BorderSizePixel = 0
Converted["_Line3"].Position = UDim2.new(0, 0, 0.660000026, 0)
Converted["_Line3"].Size = UDim2.new(1, 0, 0, 3)
Converted["_Line3"].Name = "Line"
Converted["_Line3"].Parent = Converted["_RuleOfThirds"]

Converted["_Phi"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Phi"].BackgroundTransparency = 1
Converted["_Phi"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Phi"].BorderSizePixel = 0
Converted["_Phi"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Phi"].Visible = false
Converted["_Phi"].Name = "Phi"
Converted["_Phi"].Parent = Converted["_Grids"]

Converted["_Line4"].BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Converted["_Line4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line4"].BorderSizePixel = 0
Converted["_Line4"].Position = UDim2.new(0, 0, 0.330000013, 0)
Converted["_Line4"].Size = UDim2.new(1, 0, 0, 3)
Converted["_Line4"].Name = "Line"
Converted["_Line4"].Parent = Converted["_Phi"]

Converted["_Cross"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Cross"].BackgroundTransparency = 1
Converted["_Cross"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Cross"].BorderSizePixel = 0
Converted["_Cross"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Cross"].Visible = false
Converted["_Cross"].Name = "Cross"
Converted["_Cross"].Parent = Converted["_Grids"]

Converted["_Line5"].BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Converted["_Line5"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line5"].BorderSizePixel = 0
Converted["_Line5"].Position = UDim2.new(0, 0, 0.5, 0)
Converted["_Line5"].Size = UDim2.new(1, 0, 0, 3)
Converted["_Line5"].Name = "Line"
Converted["_Line5"].Parent = Converted["_Cross"]

Converted["_Line6"].BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Converted["_Line6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line6"].BorderSizePixel = 0
Converted["_Line6"].Position = UDim2.new(0.5, 0, 0, 0)
Converted["_Line6"].Size = UDim2.new(0, 3, 1, 0)
Converted["_Line6"].Name = "Line"
Converted["_Line6"].Parent = Converted["_Cross"]

Converted["_Fibonacci"].BackgroundColor3 = Color3.fromRGB(188, 0, 3)
Converted["_Fibonacci"].BackgroundTransparency = 1
Converted["_Fibonacci"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Fibonacci"].BorderSizePixel = 0
Converted["_Fibonacci"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Fibonacci"].Visible = false
Converted["_Fibonacci"].Name = "Fibonacci"
Converted["_Fibonacci"].Parent = Converted["_Grids"]

Converted["_Frame"].AnchorPoint = Vector2.new(1, 0)
Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame"].BackgroundTransparency = 1
Converted["_Frame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame"].BorderSizePixel = 0
Converted["_Frame"].Position = UDim2.new(1, 0, 0, 0)
Converted["_Frame"].Size = UDim2.new(0.617999971, 0, 1, 0)
Converted["_Frame"].Parent = Converted["_Fibonacci"]

Converted["_UIStroke"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke"].Parent = Converted["_Frame"]

Converted["_Frame1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame1"].BackgroundTransparency = 1
Converted["_Frame1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame1"].BorderSizePixel = 0
Converted["_Frame1"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame1"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Frame1"].Parent = Converted["_Frame"]

Converted["_UIAspectRatioConstraint"].Parent = Converted["_Frame1"]

Converted["_UIStroke1"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke1"].Parent = Converted["_Frame1"]

Converted["_UICorner"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner"].Parent = Converted["_Frame1"]

Converted["_Frame2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame2"].BackgroundTransparency = 1
Converted["_Frame2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame2"].BorderSizePixel = 0
Converted["_Frame2"].Size = UDim2.new(0.381000012, 0, 0.617999971, 0)
Converted["_Frame2"].Parent = Converted["_Fibonacci"]

Converted["_UIStroke2"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke2"].Parent = Converted["_Frame2"]

Converted["_Frame3"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame3"].BackgroundTransparency = 1
Converted["_Frame3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame3"].BorderSizePixel = 0
Converted["_Frame3"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame3"].Size = UDim2.new(0.67971313, 0, 1, 0)
Converted["_Frame3"].Parent = Converted["_Frame2"]

Converted["_UIAspectRatioConstraint1"].Parent = Converted["_Frame3"]

Converted["_UIStroke3"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke3"].Parent = Converted["_Frame3"]

Converted["_UICorner1"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner1"].Parent = Converted["_Frame3"]

Converted["_Frame4"].AnchorPoint = Vector2.new(0, 1)
Converted["_Frame4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame4"].BackgroundTransparency = 1
Converted["_Frame4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame4"].BorderSizePixel = 0
Converted["_Frame4"].Position = UDim2.new(0, 0, 1, 0)
Converted["_Frame4"].Size = UDim2.new(0.23623623, 0, 0.381877035, 0)
Converted["_Frame4"].Parent = Converted["_Fibonacci"]

Converted["_UIStroke4"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke4"].Parent = Converted["_Frame4"]

Converted["_Frame5"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame5"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame5"].BackgroundTransparency = 1
Converted["_Frame5"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame5"].BorderSizePixel = 0
Converted["_Frame5"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame5"].Size = UDim2.new(0.67971313, 0, 1, 0)
Converted["_Frame5"].Parent = Converted["_Frame4"]

Converted["_UIAspectRatioConstraint2"].Parent = Converted["_Frame5"]

Converted["_UIStroke5"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke5"].Parent = Converted["_Frame5"]

Converted["_UICorner2"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner2"].Parent = Converted["_Frame5"]

Converted["_Frame6"].AnchorPoint = Vector2.new(0, 1)
Converted["_Frame6"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame6"].BackgroundTransparency = 1
Converted["_Frame6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame6"].BorderSizePixel = 0
Converted["_Frame6"].Position = UDim2.new(0.236000001, 0, 1, 0)
Converted["_Frame6"].Size = UDim2.new(0.145145148, 0, 0.234627828, 0)
Converted["_Frame6"].Parent = Converted["_Fibonacci"]

Converted["_UIStroke6"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke6"].Parent = Converted["_Frame6"]

Converted["_Frame7"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame7"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame7"].BackgroundTransparency = 1
Converted["_Frame7"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame7"].BorderSizePixel = 0
Converted["_Frame7"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame7"].Size = UDim2.new(0.679033399, 0, 1, 0)
Converted["_Frame7"].Parent = Converted["_Frame6"]

Converted["_UIAspectRatioConstraint3"].Parent = Converted["_Frame7"]

Converted["_UIStroke7"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke7"].Parent = Converted["_Frame7"]

Converted["_UICorner3"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner3"].Parent = Converted["_Frame7"]

Converted["_Frame8"].AnchorPoint = Vector2.new(0, 1)
Converted["_Frame8"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame8"].BackgroundTransparency = 1
Converted["_Frame8"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame8"].BorderSizePixel = 0
Converted["_Frame8"].Position = UDim2.new(0.291999996, 0, 0.76375407, 0)
Converted["_Frame8"].Size = UDim2.new(0.0900900885, 0, 0.145631075, 0)
Converted["_Frame8"].Parent = Converted["_Fibonacci"]

Converted["_UIStroke8"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke8"].Parent = Converted["_Frame8"]

Converted["_Frame9"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame9"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame9"].BackgroundTransparency = 1
Converted["_Frame9"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame9"].BorderSizePixel = 0
Converted["_Frame9"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame9"].Size = UDim2.new(0.679033399, 0, 1, 0)
Converted["_Frame9"].Parent = Converted["_Frame8"]

Converted["_UIAspectRatioConstraint4"].Parent = Converted["_Frame9"]

Converted["_UIStroke9"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke9"].Parent = Converted["_Frame9"]

Converted["_UICorner4"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner4"].Parent = Converted["_Frame9"]

Converted["_Frame10"].AnchorPoint = Vector2.new(0, 1)
Converted["_Frame10"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame10"].BackgroundTransparency = 1
Converted["_Frame10"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame10"].BorderSizePixel = 0
Converted["_Frame10"].Position = UDim2.new(0.235999003, 0, 0.707119763, 0)
Converted["_Frame10"].Size = UDim2.new(0.0550550558, 0, 0.0889967605, 0)
Converted["_Frame10"].Parent = Converted["_Fibonacci"]

Converted["_UIStroke10"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke10"].Parent = Converted["_Frame10"]

Converted["_Frame11"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame11"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame11"].BackgroundTransparency = 1
Converted["_Frame11"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame11"].BorderSizePixel = 0
Converted["_Frame11"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame11"].Size = UDim2.new(0.679033399, 0, 0.99999994, 0)
Converted["_Frame11"].Parent = Converted["_Frame10"]

Converted["_UIAspectRatioConstraint5"].Parent = Converted["_Frame11"]

Converted["_UIStroke11"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke11"].Parent = Converted["_Frame11"]

Converted["_UICorner5"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner5"].Parent = Converted["_Frame11"]

Converted["_Frame12"].AnchorPoint = Vector2.new(0, 1)
Converted["_Frame12"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame12"].BackgroundTransparency = 1
Converted["_Frame12"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame12"].BorderSizePixel = 0
Converted["_Frame12"].Position = UDim2.new(0.235999003, 0, 0.763753891, 0)
Converted["_Frame12"].Size = UDim2.new(0.0550550558, 0, 0.0550161824, 0)
Converted["_Frame12"].Parent = Converted["_Fibonacci"]

Converted["_UIStroke12"].Color = Color3.fromRGB(255, 0, 4)
Converted["_UIStroke12"].Parent = Converted["_Frame12"]

Converted["_ScreenSizeFrame"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ScreenSizeFrame"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ScreenSizeFrame"].BackgroundTransparency = 1
Converted["_ScreenSizeFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ScreenSizeFrame"].BorderSizePixel = 0
Converted["_ScreenSizeFrame"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_ScreenSizeFrame"].Size = UDim2.new(0.9, 0, 0.9, 0)
Converted["_ScreenSizeFrame"].Name = "ScreenSizeFrame"
Converted["_ScreenSizeFrame"].Parent = Converted["_DevUI"]

Converted["_Reminder"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Reminder"].AutomaticSize = Enum.AutomaticSize.X
Converted["_Reminder"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Reminder"].BackgroundTransparency = 1
Converted["_Reminder"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Reminder"].BorderSizePixel = 0
Converted["_Reminder"].Position = UDim2.new(0.5, 0, 0.819492519, 0)
Converted["_Reminder"].Size = UDim2.new(0, 0, 0, 20)
Converted["_Reminder"].Name = "Reminder"
Converted["_Reminder"].Parent = Converted["_ScreenSizeFrame"]

Converted["_TextLabel"].FontFace = theme.font.semiBold
Converted["_TextLabel"].Text = "YOU ARE IN DEVELOPER MODE"
Converted["_TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].TextSize = 14
Converted["_TextLabel"].TextTransparency = 0.5
Converted["_TextLabel"].AutomaticSize = Enum.AutomaticSize.X
Converted["_TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].BackgroundTransparency = 1
Converted["_TextLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel"].BorderSizePixel = 0
Converted["_TextLabel"].LayoutOrder = 1
Converted["_TextLabel"].Size = UDim2.new(0, 0, 1, 0)
Converted["_TextLabel"].Parent = Converted["_Reminder"]

Converted["_ImageLabel"].Image = "rbxassetid://13536538211"
Converted["_ImageLabel"].ImageTransparency = 0.5
Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ImageLabel"].BackgroundTransparency = 1
Converted["_ImageLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ImageLabel"].BorderSizePixel = 0
Converted["_ImageLabel"].Size = UDim2.new(1, 0, 1, 0)
Converted["_ImageLabel"].Parent = Converted["_Reminder"]

Converted["_UIAspectRatioConstraint6"].Parent = Converted["_ImageLabel"]

Converted["_UIListLayout"].Padding = UDim.new(0, 5)
Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout"].Parent = Converted["_Reminder"]

Converted["_Output"].AnchorPoint = Vector2.new(0, 1)
Converted["_Output"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Output"].BackgroundTransparency = 1
Converted["_Output"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Output"].BorderSizePixel = 0
Converted["_Output"].Position = UDim2.new(0, 0, 1, 0)
Converted["_Output"].Size = UDim2.new(0, 220, 0, 12)
Converted["_Output"].Name = "Output"
Converted["_Output"].Parent = Converted["_ScreenSizeFrame"]

Converted["_UIListLayout1"].Padding = UDim.new(0, 1)
Converted["_UIListLayout1"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Bottom
Converted["_UIListLayout1"].Parent = Converted["_Output"]

Converted["_DevtoolsButton"].Image = "rbxassetid://13536538211"
Converted["_DevtoolsButton"].ImageTransparency = 0.5
Converted["_DevtoolsButton"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_DevtoolsButton"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Converted["_DevtoolsButton"].BackgroundTransparency = 0.5
Converted["_DevtoolsButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_DevtoolsButton"].BorderSizePixel = 0
Converted["_DevtoolsButton"].Position = UDim2.new(0, 0, 0.5, 0)
Converted["_DevtoolsButton"].Size = UDim2.new(0, 26, 0, 26)
Converted["_DevtoolsButton"].Name = "DevtoolsButton"
Converted["_DevtoolsButton"].Parent = Converted["_ScreenSizeFrame"]

Converted["_UICorner6"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner6"].Parent = Converted["_DevtoolsButton"]

Converted["_UIStroke13"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke13"].Parent = Converted["_DevtoolsButton"]

Converted["_Devtools"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Devtools"].BackgroundColor3 = theme.ui_background_color
Converted["_Devtools"].BackgroundTransparency = 0.05
Converted["_Devtools"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Devtools"].BorderSizePixel = 0
Converted["_Devtools"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Devtools"].Size = UDim2.new(0.6, 0, 0.6, 0)
Converted["_Devtools"].Name = "Devtools"
Converted["_Devtools"].Parent = Converted["_ScreenSizeFrame"]

Converted["_UICorner7"].Parent = Converted["_Devtools"]

Converted["_UIStroke14"].Color = theme.ui_stroke_color
Converted["_UIStroke14"].Parent = Converted["_Devtools"]

Converted["_Titlebar"].BackgroundColor3 = theme.ui_titlebar_color
Converted["_Titlebar"].BackgroundTransparency = 0.5
Converted["_Titlebar"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Titlebar"].BorderSizePixel = 0
Converted["_Titlebar"].Size = UDim2.new(1, 0, 0.100000001, 0)
Converted["_Titlebar"].Name = "Titlebar"
Converted["_Titlebar"].Parent = Converted["_Devtools"]

Converted["_TextLabel1"].FontFace = theme.font.semiBold
Converted["_TextLabel1"].Text = "DEVTOOLS"
Converted["_TextLabel1"].TextColor3 = theme.ui_titlebar_content_color
Converted["_TextLabel1"].TextSize = 14
Converted["_TextLabel1"].TextTransparency = 0.5
Converted["_TextLabel1"].AnchorPoint = Vector2.new(0, 0.5)
Converted["_TextLabel1"].AutomaticSize = Enum.AutomaticSize.X
Converted["_TextLabel1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel1"].BackgroundTransparency = 1
Converted["_TextLabel1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel1"].BorderSizePixel = 0
Converted["_TextLabel1"].LayoutOrder = 1
Converted["_TextLabel1"].Position = UDim2.new(0.0498496816, 0, 0.5, 0)
Converted["_TextLabel1"].Size = UDim2.new(0, 0, 1, 0)
Converted["_TextLabel1"].Parent = Converted["_Titlebar"]

Converted["_ImageLabel1"].Image = "rbxassetid://13536538211"
Converted["_ImageLabel1"].ImageTransparency = 0.5
Converted["_ImageLabel1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ImageLabel1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ImageLabel1"].ImageColor3 = theme.ui_titlebar_content_color
Converted["_ImageLabel1"].BackgroundTransparency = 1
Converted["_ImageLabel1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ImageLabel1"].BorderSizePixel = 0
Converted["_ImageLabel1"].Position = UDim2.new(0.0287218355, 0, 0.499999911, 0)
Converted["_ImageLabel1"].Size = UDim2.new(0.5, 0, 0.5, 0)
Converted["_ImageLabel1"].Parent = Converted["_Titlebar"]

Converted["_UIAspectRatioConstraint7"].Parent = Converted["_ImageLabel1"]

Converted["_IGNORE_spacer"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_IGNORE_spacer"].BackgroundTransparency = 1
Converted["_IGNORE_spacer"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_IGNORE_spacer"].BorderSizePixel = 0
Converted["_IGNORE_spacer"].LayoutOrder = -1
Converted["_IGNORE_spacer"].Size = UDim2.new(0, 10, 0, 10)
Converted["_IGNORE_spacer"].Name = "IGNORE_spacer"
Converted["_IGNORE_spacer"].Parent = Converted["_Titlebar"]

Converted["_UICorner8"].Parent = Converted["_Titlebar"]

Converted["_UIStroke15"].Color = theme.ui_stroke_color
Converted["_UIStroke15"].Parent = Converted["_Titlebar"]

Converted["_Close"].FontFace = theme.font.bold
Converted["_Close"].Text = "X"
Converted["_Close"].TextColor3 = Color3.fromRGB(91, 91, 91)
Converted["_Close"].TextSize = 10
Converted["_Close"].AutoButtonColor = false
Converted["_Close"].Active = false
Converted["_Close"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Close"].BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Converted["_Close"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Close"].BorderSizePixel = 0
Converted["_Close"].Position = UDim2.new(0.971000016, 0, 0.5, 0)
Converted["_Close"].Selectable = false
Converted["_Close"].Size = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Close"].Name = "Close"
Converted["_Close"].Parent = Converted["_Titlebar"]

Converted["_UIAspectRatioConstraint8"].Parent = Converted["_Close"]

Converted["_UICorner9"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner9"].Parent = Converted["_Close"]

Converted["_Container"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Container"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Container"].BackgroundTransparency = 1
Converted["_Container"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Container"].BorderSizePixel = 0
Converted["_Container"].Position = UDim2.new(0.5, 0, 0.550000012, 0)
Converted["_Container"].Size = UDim2.new(1, -30, 0.899999976, -30)
Converted["_Container"].Name = "Container"
Converted["_Container"].Parent = Converted["_Devtools"]

Converted["_leftScroller"].AutomaticCanvasSize = Enum.AutomaticSize.Y
Converted["_leftScroller"].CanvasSize = UDim2.new(0, 0, 0, 0)
Converted["_leftScroller"].ScrollBarThickness = 2
Converted["_leftScroller"].Active = true
Converted["_leftScroller"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_leftScroller"].BackgroundTransparency = 1
Converted["_leftScroller"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_leftScroller"].BorderSizePixel = 0
Converted["_leftScroller"].Size = UDim2.new(0.49000001, 0, 1, 0)
Converted["_leftScroller"].Name = "leftScroller"
Converted["_leftScroller"].Parent = Converted["_Container"]

Converted["_UIListLayout2"].Padding = UDim.new(0, 5)
Converted["_UIListLayout2"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout2"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout2"].Parent = Converted["_leftScroller"]

Converted["_CatDivider"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_CatDivider"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_CatDivider"].BackgroundTransparency = 1
Converted["_CatDivider"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_CatDivider"].BorderSizePixel = 0
Converted["_CatDivider"].ClipsDescendants = true
Converted["_CatDivider"].Size = UDim2.new(0.899999976, 0, 0, 35)
Converted["_CatDivider"].Name = "CatDivider"
Converted["_CatDivider"].Parent = Converted["_leftScroller"]

Converted["_Label"].FontFace = theme.font.semiBold
Converted["_Label"].Text = "Subcategory"
Converted["_Label"].TextColor3 = theme.ui_divider_group_color
Converted["_Label"].TextSize = 14
Converted["_Label"].AutomaticSize = Enum.AutomaticSize.X
Converted["_Label"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Label"].BackgroundTransparency = 1
Converted["_Label"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Label"].BorderSizePixel = 0
Converted["_Label"].LayoutOrder = 1
Converted["_Label"].Size = UDim2.new(0, 0, 1, 0)
Converted["_Label"].Name = "Label"
Converted["_Label"].Parent = Converted["_CatDivider"]

Converted["_UIListLayout3"].Padding = UDim.new(0, 5)
Converted["_UIListLayout3"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout3"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout3"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout3"].VerticalAlignment = Enum.VerticalAlignment.Center
Converted["_UIListLayout3"].Parent = Converted["_CatDivider"]

Converted["_Line7"].BackgroundColor3 = theme.ui_divider_group_color
Converted["_Line7"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line7"].BorderSizePixel = 0
Converted["_Line7"].Size = UDim2.new(1, 0, 0, 1)
Converted["_Line7"].Name = "Line"
Converted["_Line7"].Parent = Converted["_CatDivider"]

Converted["_Line8"].BackgroundColor3 = theme.ui_divider_group_color
Converted["_Line8"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Line8"].BorderSizePixel = 0
Converted["_Line8"].LayoutOrder = 2
Converted["_Line8"].Size = UDim2.new(1, 0, 0, 1)
Converted["_Line8"].Name = "Line"
Converted["_Line8"].Parent = Converted["_CatDivider"]

Converted["_toggleButtonContainer"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_toggleButtonContainer"].BackgroundTransparency = 1
Converted["_toggleButtonContainer"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_toggleButtonContainer"].BorderSizePixel = 0
Converted["_toggleButtonContainer"].Size = UDim2.new(0.899999976, 0, 0, 31)
Converted["_toggleButtonContainer"].Name = "toggleButtonContainer"
Converted["_toggleButtonContainer"].Parent = Converted["_leftScroller"]

Converted["_Click"].Font = Enum.Font.SourceSans
Converted["_Click"].Text = ""
Converted["_Click"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Click"].TextSize = 14
Converted["_Click"].AutoButtonColor = false
Converted["_Click"].BackgroundColor3 = theme.ui_button_background_color
Converted["_Click"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Click"].BorderSizePixel = 0
Converted["_Click"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Click"].Name = "Click"
Converted["_Click"].Parent = Converted["_toggleButtonContainer"]

Converted["_UICorner10"].CornerRadius = UDim.new(2, 0)
Converted["_UICorner10"].Parent = Converted["_Click"]

Converted["_Label1"].FontFace = theme.font.bold
Converted["_Label1"].Text = "Whatever whatever whatever"
Converted["_Label1"].TextColor3 = theme.ui_button_text_color
Converted["_Label1"].TextSize = 15
Converted["_Label1"].AutomaticSize = Enum.AutomaticSize.X
Converted["_Label1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Label1"].BackgroundTransparency = 1
Converted["_Label1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Label1"].BorderSizePixel = 0

Converted["_Label1"].Size = UDim2.new(0, 0, 1, 0)
Converted["_Label1"].Name = "Label"
Converted["_Label1"].Parent = Converted["_Click"]

Converted["_sliderContainer"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_sliderContainer"].BackgroundTransparency = 1
Converted["_sliderContainer"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_sliderContainer"].BorderSizePixel = 0
Converted["_sliderContainer"].ClipsDescendants = true
Converted["_sliderContainer"].Size = UDim2.new(0, 45, 0.7, 1)

Converted["_sliderContainer"].Name = "sliderContainer"
Converted["_sliderContainer"].Parent = Converted["_Click"]

Converted["_Slider"].AnchorPoint = Vector2.new(1, 0)
Converted["_Slider"].BackgroundColor3 = theme.ui_button_slider_off_color
Converted["_Slider"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Slider"].BorderSizePixel = 0
Converted["_Slider"].ClipsDescendants = true
Converted["_Slider"].Position = UDim2.new(1, 0, 0, 0)
Converted["_Slider"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Slider"].Name = "Slider"
Converted["_Slider"].Parent = Converted["_sliderContainer"]

Converted["_UICorner11"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner11"].Parent = Converted["_Slider"]

Converted["_UIAspectRatioConstraint9"].AspectRatio = 2
Converted["_UIAspectRatioConstraint9"].Parent = Converted["_Slider"]

Converted["_sliderAccent"].AnchorPoint = Vector2.new(1, 0.5)
Converted["_sliderAccent"].BackgroundColor3 = theme.ui_button_slider_on_color
Converted["_sliderAccent"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_sliderAccent"].BorderSizePixel = 0
Converted["_sliderAccent"].Position = UDim2.new(0.25, 0, 0.5, 0)
Converted["_sliderAccent"].Size = UDim2.new(1, 0, 1, 0)
Converted["_sliderAccent"].ZIndex = 0
Converted["_sliderAccent"].Name = "sliderAccent"
Converted["_sliderAccent"].Parent = Converted["_Slider"]

Converted["_sliderCircle"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_sliderCircle"].BackgroundColor3 = theme.ui_button_slider_circle_color
Converted["_sliderCircle"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_sliderCircle"].BorderSizePixel = 0
Converted["_sliderCircle"].Position = UDim2.new(1, 0, 0.5, 0)
Converted["_sliderCircle"].Size = UDim2.new(1, 0, 1, 0)
Converted["_sliderCircle"].Name = "sliderCircle"
Converted["_sliderCircle"].Parent = Converted["_sliderAccent"]

Converted["_UIAspectRatioConstraint10"].Parent = Converted["_sliderCircle"]

Converted["_UICorner12"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner12"].Parent = Converted["_sliderCircle"]

Converted["_strokeHelper"].BackgroundColor3 = theme.ui_button_background_color
Converted["_strokeHelper"].BackgroundTransparency = 1
Converted["_strokeHelper"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_strokeHelper"].BorderSizePixel = 0
Converted["_strokeHelper"].Size = UDim2.new(1, 0, 1, 0)
Converted["_strokeHelper"].Name = "strokeHelper"
Converted["_strokeHelper"].Parent = Converted["_Slider"]

Converted["_UIStroke16"].Color = theme.ui_button_background_color
Converted["_UIStroke16"].Thickness = 10
Converted["_UIStroke16"].Parent = Converted["_strokeHelper"]

Converted["_UICorner13"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner13"].Parent = Converted["_strokeHelper"]

Converted["_TooltipContainer"].AnchorPoint = Vector2.new(0, 1)
Converted["_TooltipContainer"].BackgroundColor3 = theme.ui_button_tooltip_background_color
Converted["_TooltipContainer"].BackgroundTransparency = 1
Converted["_TooltipContainer"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TooltipContainer"].BorderSizePixel = 0
Converted["_TooltipContainer"].Position = UDim2.new(0, 0, 1, 0)
Converted["_TooltipContainer"].Size = UDim2.new(1, 0, 1, 0)
Converted["_TooltipContainer"].ZIndex = 0
Converted["_TooltipContainer"].Name = "TooltipContainer"
Converted["_TooltipContainer"].Parent = Converted["_toggleButtonContainer"]

Converted["_Tooltip"].FontFace = theme.font.regular
Converted["_Tooltip"].Text = "Does the 'whatever whatever whatever' thing"
Converted["_Tooltip"].TextColor3 = theme.ui_button_tooltip_text_color
Converted["_Tooltip"].TextSize = 14
Converted["_Tooltip"].TextTransparency = 1
Converted["_Tooltip"].AnchorPoint = Vector2.new(0, 1)
Converted["_Tooltip"].BackgroundColor3 = theme.ui_button_tooltip_background_color
Converted["_Tooltip"].BackgroundTransparency = 1
Converted["_Tooltip"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Tooltip"].BorderSizePixel = 0
Converted["_Tooltip"].Position = UDim2.new(0, 0, 1, 0)
Converted["_Tooltip"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Tooltip"].Name = "Tooltip"
Converted["_Tooltip"].Parent = Converted["_TooltipContainer"]

Converted["_UICorner14"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner14"].Parent = Converted["_Tooltip"]

Converted["_momentaryButtonContainer"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_momentaryButtonContainer"].BackgroundTransparency = 1
Converted["_momentaryButtonContainer"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_momentaryButtonContainer"].BorderSizePixel = 0
Converted["_momentaryButtonContainer"].Size = UDim2.new(0.9, 0, 0, 31)
Converted["_momentaryButtonContainer"].Name = "momentaryButtonContainer"
Converted["_momentaryButtonContainer"].Parent = Converted["_leftScroller"]

Converted["_Click1"].FontFace = theme.font.regular
Converted["_Click1"].Text = ""
Converted["_Click1"].TextColor3 = theme.ui_button_text_color
Converted["_Click1"].TextSize = 14
Converted["_Click1"].AutoButtonColor = false
Converted["_Click1"].BackgroundColor3 = theme.ui_button_background_color
Converted["_Click1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Click1"].BorderSizePixel = 0
Converted["_Click1"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Click1"].Name = "Click"
Converted["_Click1"].Parent = Converted["_momentaryButtonContainer"]

Converted["_UICorner15"].CornerRadius = UDim.new(2, 0)
Converted["_UICorner15"].Parent = Converted["_Click1"]

Converted["_Label2"].FontFace = theme.font.semiBold
Converted["_Label2"].Text = "Whatever whatever whatever"
Converted["_Label2"].TextColor3 = theme.ui_button_text_color
Converted["_Label2"].TextSize = 15
Converted["_Label2"].AutomaticSize = Enum.AutomaticSize.X
Converted["_Label2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Label2"].BackgroundTransparency = 1
Converted["_Label2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Label2"].BorderSizePixel = 0

Converted["_Label2"].Size = UDim2.new(0, 0, 1, 0)
Converted["_Label2"].Name = "Label"
Converted["_Label2"].Parent = Converted["_Click1"]

Converted["_TooltipContainer1"].AnchorPoint = Vector2.new(0, 1)
Converted["_TooltipContainer1"].BackgroundColor3 = theme.ui_button_tooltip_background_color
Converted["_TooltipContainer1"].BackgroundTransparency = 1
Converted["_TooltipContainer1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TooltipContainer1"].BorderSizePixel = 0
Converted["_TooltipContainer1"].Position = UDim2.new(0, 0, 1, 0)
Converted["_TooltipContainer1"].Size = UDim2.new(1, 0, 1, 0)
Converted["_TooltipContainer1"].ZIndex = 0
Converted["_TooltipContainer1"].Name = "TooltipContainer"
Converted["_TooltipContainer1"].Parent = Converted["_momentaryButtonContainer"]

Converted["_Tooltip1"].FontFace = theme.font.regular
Converted["_Tooltip1"].Text = "Does the 'whatever whatever whatever' thing"
Converted["_Tooltip1"].TextColor3 = theme.ui_button_tooltip_text_color
Converted["_Tooltip1"].TextSize = 14
Converted["_Tooltip1"].TextTransparency = 1
Converted["_Tooltip1"].AnchorPoint = Vector2.new(0, 1)
Converted["_Tooltip1"].BackgroundColor3 = theme.ui_button_tooltip_background_color
Converted["_Tooltip1"].BackgroundTransparency = 1
Converted["_Tooltip1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Tooltip1"].BorderSizePixel = 0
Converted["_Tooltip1"].Position = UDim2.new(0, 0, 1, 0)
Converted["_Tooltip1"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Tooltip1"].Name = "Tooltip"
Converted["_Tooltip1"].Parent = Converted["_TooltipContainer1"]

Converted["_UICorner16"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner16"].Parent = Converted["_Tooltip1"]

Converted["_rightScroller"].AutomaticCanvasSize = Enum.AutomaticSize.Y
Converted["_rightScroller"].CanvasSize = UDim2.new(0, 0, 0, 0)
Converted["_rightScroller"].ScrollBarThickness = 2
Converted["_rightScroller"].VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
Converted["_rightScroller"].Active = true
Converted["_rightScroller"].AnchorPoint = Vector2.new(1, 0)
Converted["_rightScroller"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_rightScroller"].BackgroundTransparency = 1
Converted["_rightScroller"].ScrollBarImageColor3 = theme.ui_scrollbar_color
Converted["_rightScroller"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_rightScroller"].BorderSizePixel = 0
Converted["_rightScroller"].Position = UDim2.new(1, 0, 0, 0)
Converted["_rightScroller"].Size = UDim2.new(0.49000001, 0, 1, 0)
Converted["_rightScroller"].Name = "rightScroller"
Converted["_rightScroller"].Parent = Converted["_Container"]

Converted["_UIListLayout4"].Padding = UDim.new(0, 5)
Converted["_UIListLayout4"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout4"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout4"].Parent = Converted["_rightScroller"]

Converted["_Modal"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Modal"].BackgroundTransparency = 0.1
Converted["_Modal"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Modal"].BorderSizePixel = 0
Converted["_Modal"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Modal"].Visible = false
Converted["_Modal"].Name = "Modal"
Converted["_Modal"].Parent = Converted["_Devtools"]

Converted["_TextLabel2"].FontFace = theme.font.bold
Converted["_TextLabel2"].Text = "FATAL ERROR"
Converted["_TextLabel2"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel2"].TextSize = 14
Converted["_TextLabel2"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel2"].BackgroundTransparency = 1
Converted["_TextLabel2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel2"].BorderSizePixel = 0
Converted["_TextLabel2"].Position = UDim2.new(0.5, 0, 0.391441584, 0)
Converted["_TextLabel2"].Size = UDim2.new(0, 200, 0, 42)
Converted["_TextLabel2"].Parent = Converted["_Modal"]

Converted["_Frame13"].AnchorPoint = Vector2.new(0.5, 1)
Converted["_Frame13"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame13"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame13"].BorderSizePixel = 0
Converted["_Frame13"].Position = UDim2.new(0.5, 0, 1, 0)
Converted["_Frame13"].Size = UDim2.new(0, 100, 0, 1)
Converted["_Frame13"].Parent = Converted["_TextLabel2"]

Converted["_TextLabel3"].FontFace = theme.font.semiBold
Converted["_TextLabel3"].Text =
	"DevTools cannot run because there are no UI instances set. Go and set UI instances in the DevTools script in StarterPlayerScripts."
Converted["_TextLabel3"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel3"].TextSize = 14
Converted["_TextLabel3"].TextWrapped = true
Converted["_TextLabel3"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel3"].BackgroundTransparency = 1
Converted["_TextLabel3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel3"].BorderSizePixel = 0
Converted["_TextLabel3"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_TextLabel3"].Size = UDim2.new(0.6, 0, 0, 50)
Converted["_TextLabel3"].Parent = Converted["_Modal"]

if not theme.rightToLeft then
	Converted["_sliderContainer"].AnchorPoint = Vector2.new(1, 0.5)
	Converted["_sliderContainer"].Position = UDim2.new(1, -7, 0.5, 0)

	Converted["_Label1"].AnchorPoint = Vector2.new(0, 0)
	Converted["_Label1"].TextXAlignment = Enum.TextXAlignment.Left
	Converted["_Label1"].Position = UDim2.new(0, 15, 0, 0)

	Converted["_Label2"].AnchorPoint = Vector2.new(0, 0)
	Converted["_Label2"].TextXAlignment = Enum.TextXAlignment.Left
	Converted["_Label2"].Position = UDim2.new(0, 15, 0, 0)
else
	Converted["_sliderContainer"].AnchorPoint = Vector2.new(0, 0.5)
	Converted["_sliderContainer"].Position = UDim2.new(0, 7, 0.5, 0)

	Converted["_Label1"].AnchorPoint = Vector2.new(1, 0)
	Converted["_Label1"].TextXAlignment = Enum.TextXAlignment.Right
	Converted["_Label1"].Position = UDim2.new(1, -15, 0, 0)

	Converted["_Label2"].AnchorPoint = Vector2.new(1, 0)
	Converted["_Label2"].TextXAlignment = Enum.TextXAlignment.Right
	Converted["_Label2"].Position = UDim2.new(1, -15, 0, 0)
end

states.convertedGUILoaded = true

script:Destroy()
