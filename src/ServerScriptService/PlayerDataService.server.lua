--[[
	PlayerDataService.server.lua
	Handles per-player coin balance + unlocked decks, with DataStore persistence.
	Place under ServerScriptService.
]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))
local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local cruiseStore = DataStoreService:GetDataStore("CruiseLine2026_PlayerData_v1")

local playerData = {} -- [player] = { Coins = number, UnlockedDecks = {[deckName]=true} }

local function defaultData()
	local data = { Coins = 0, UnlockedDecks = {} }
	data.UnlockedDecks[GameConfig.Decks[1].Name] = true -- Main Deck free by default
	return data
end

local function loadData(player)
	local success, result = pcall(function()
		return cruiseStore:GetAsync("Player_" .. player.UserId)
	end)

	if success and result then
		playerData[player] = result
	else
		playerData[player] = defaultData()
	end

	RemoteEvents.UpdateCoins:FireClient(player, playerData[player].Coins)
end

local function saveData(player)
	local data = playerData[player]
	if not data then return end

	local success, err = pcall(function()
		cruiseStore:SetAsync("Player_" .. player.UserId, data)
	end)

	if not success then
		warn("[CruiseLine2026] Failed to save data for " .. player.Name .. ": " .. tostring(err))
	end
end

local function addCoins(player, amount)
	local data = playerData[player]
	if not data then return end
	data.Coins = math.max(0, data.Coins + amount)
	RemoteEvents.UpdateCoins:FireClient(player, data.Coins)
end

Players.PlayerAdded:Connect(loadData)

Players.PlayerRemoving:Connect(function(player)
	saveData(player)
	playerData[player] = nil
end)

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		saveData(player)
	end
end)

-- Deck unlocking
RemoteEvents.UnlockDeck.OnServerEvent:Connect(function(player, deckName)
	local data = playerData[player]
	if not data then return end

	for _, deck in ipairs(GameConfig.Decks) do
		if deck.Name == deckName then
			if data.UnlockedDecks[deckName] then
				return -- already unlocked
			end
			if data.Coins >= deck.UnlockCost then
				data.Coins -= deck.UnlockCost
				data.UnlockedDecks[deckName] = true
				RemoteEvents.UpdateCoins:FireClient(player, data.Coins)
				RemoteEvents.UnlockDeck:FireClient(player, deckName, true)
			else
				RemoteEvents.UnlockDeck:FireClient(player, deckName, false)
			end
			return
		end
	end
end)

-- Mini-game payouts (buffet tips, pool game, casino, etc.)
RemoteEvents.PlayMiniGameResult.OnServerEvent:Connect(function(player, gameName)
	local reward = 0
	if gameName == "Buffet" then
		reward = GameConfig.Rewards.BuffetTip
	elseif gameName == "Pool" then
		reward = GameConfig.Rewards.PoolMiniGame
	elseif gameName == "Casino" then
		reward = math.random(GameConfig.Rewards.CasinoWinMin, GameConfig.Rewards.CasinoWinMax)
	end

	if reward > 0 then
		addCoins(player, reward)
	end
end)

return {
	AddCoins = addCoins,
}
