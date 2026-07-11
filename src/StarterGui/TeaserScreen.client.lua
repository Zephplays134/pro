--[[
	TeaserScreen.client.lua
	Shows a "COMING 2026" splash/teaser overlay when the game loads,
	then fades out into the normal HUD. Great for a pre-launch demo build.
	Place under StarterGui.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeaserScreen"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Full-screen ocean-blue backdrop
local backdrop = Instance.new("Frame")
backdrop.Size = UDim2.fromScale(1, 1)
backdrop.BackgroundColor3 = Color3.fromRGB(6, 34, 64)
backdrop.BorderSizePixel = 0
backdrop.Parent = screenGui

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 20, 45)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 90, 130)),
})
gradient.Rotation = 90
gradient.Parent = backdrop

-- Ship emoji / title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.8, 0, 0.2, 0)
title.Position = UDim2.fromScale(0.1, 0.32)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.Text = GameConfig.GameName
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = backdrop

-- "COMING 2026" banner
local teaser = Instance.new("TextLabel")
teaser.Size = UDim2.new(0.6, 0, 0.12, 0)
teaser.Position = UDim2.fromScale(0.2, 0.52)
teaser.BackgroundColor3 = Color3.fromRGB(255, 196, 0)
teaser.BackgroundTransparency = 0.05
teaser.Font = Enum.Font.GothamBold
teaser.Text = GameConfig.TeaserMessage
teaser.TextColor3 = Color3.fromRGB(20, 20, 20)
teaser.TextScaled = true
teaser.Parent = backdrop

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = teaser

-- Subtle pulse animation on the teaser banner
task.spawn(function()
	while teaser.Parent do
		local up = TweenService:Create(teaser, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.new(0.62, 0, 0.125, 0),
		})
		local down = TweenService:Create(teaser, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.new(0.6, 0, 0.12, 0),
		})
		up:Play()
		up.Completed:Wait()
		down:Play()
		down.Completed:Wait()
	end
end)

-- Auto fade out after a few seconds into gameplay
task.delay(4, function()
	local fade = TweenService:Create(backdrop, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {
		BackgroundTransparency = 1,
	})
	local fadeTitle = TweenService:Create(title, TweenInfo.new(1.2), { TextTransparency = 1 })
	local fadeTeaser = TweenService:Create(teaser, TweenInfo.new(1.2), { BackgroundTransparency = 1, TextTransparency = 1 })

	fade:Play()
	fadeTitle:Play()
	fadeTeaser:Play()

	fade.Completed:Wait()
	screenGui:Destroy()
end)
