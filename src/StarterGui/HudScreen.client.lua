--[[
	HudScreen.client.lua
	Persistent HUD: coin counter + "Now Docking at <Port>" banner.
	Place under StarterGui.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HudScreen"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Coin counter (top-right)
local coinFrame = Instance.new("Frame")
coinFrame.Size = UDim2.fromOffset(180, 50)
coinFrame.Position = UDim2.new(1, -200, 0, 20)
coinFrame.BackgroundColor3 = Color3.fromRGB(10, 30, 55)
coinFrame.BackgroundTransparency = 0.15
coinFrame.Parent = screenGui

local coinCorner = Instance.new("UICorner")
coinCorner.CornerRadius = UDim.new(0, 10)
coinCorner.Parent = coinFrame

local coinLabel = Instance.new("TextLabel")
coinLabel.Size = UDim2.fromScale(1, 1)
coinLabel.BackgroundTransparency = 1
coinLabel.Font = Enum.Font.GothamBold
coinLabel.Text = "🪙 0"
coinLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
coinLabel.TextScaled = true
coinLabel.Parent = coinFrame

RemoteEvents.UpdateCoins.OnClientEvent:Connect(function(amount)
	coinLabel.Text = "🪙 " .. tostring(amount)
end)

-- "Now Docking at <Port>" banner (top-center, temporary)
local portBanner = Instance.new("TextLabel")
portBanner.Size = UDim2.fromOffset(420, 40)
portBanner.Position = UDim2.new(0.5, -210, 0, 20)
portBanner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
portBanner.BackgroundTransparency = 1
portBanner.TextTransparency = 1
portBanner.Font = Enum.Font.Gotham
portBanner.TextColor3 = Color3.fromRGB(255, 255, 255)
portBanner.TextScaled = true
portBanner.Parent = screenGui

local portCorner = Instance.new("UICorner")
portCorner.CornerRadius = UDim.new(0, 8)
portCorner.Parent = portBanner

RemoteEvents.PortArrived.OnClientEvent:Connect(function(portName)
	portBanner.Text = "⚓ Now Docking at " .. portName
	local fadeIn = TweenService:Create(portBanner, TweenInfo.new(0.5), {
		BackgroundTransparency = 0.2,
		TextTransparency = 0,
	})
	fadeIn:Play()

	task.delay(5, function()
		local fadeOut = TweenService:Create(portBanner, TweenInfo.new(0.8), {
			BackgroundTransparency = 1,
			TextTransparency = 1,
		})
		fadeOut:Play()
	end)
end)
