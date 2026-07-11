--[[
	MiniGameTriggers.client.lua
	Example touch-triggers for onboard activities (buffet, pool, casino).
	In Studio, place Parts named "BuffetTrigger", "PoolTrigger", "CasinoTrigger"
	anywhere in Workspace (e.g. inside the ship model) and touching them
	as the player will award coins via the server.
	Place under StarterPlayerScripts.
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))

local player = Players.LocalPlayer

local TRIGGER_COOLDOWN = 3 -- seconds, prevents spamming a trigger
local lastTriggered = {}

local TRIGGER_MAP = {
	BuffetTrigger = "Buffet",
	PoolTrigger = "Pool",
	CasinoTrigger = "Casino",
}

local function onCharacterAdded(character)
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	humanoidRootPart.Touched:Connect(function(hit)
		local gameName = TRIGGER_MAP[hit.Name]
		if not gameName then return end

		local now = os.clock()
		if lastTriggered[gameName] and now - lastTriggered[gameName] < TRIGGER_COOLDOWN then
			return
		end
		lastTriggered[gameName] = now

		RemoteEvents.PlayMiniGameResult:FireServer(gameName)
	end)
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
	onCharacterAdded(player.Character)
end
