--[[
	PortRotationService.server.lua
	Simulates the cruise ship sailing between ports on a timer,
	broadcasting arrivals to all clients (e.g. for a "Now Docking at..." banner).
	Place under ServerScriptService.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))
local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local currentPortIndex = 1

local function announcePort()
	local portName = GameConfig.Ports[currentPortIndex]
	RemoteEvents.PortArrived:FireAllClients(portName)
	print(("[CruiseLine2026] Ship has arrived at %s"):format(portName))
end

task.spawn(function()
	announcePort() -- announce starting port immediately

	while true do
		task.wait(GameConfig.PortRotationSeconds)
		currentPortIndex = (currentPortIndex % #GameConfig.Ports) + 1
		announcePort()
	end
end)
