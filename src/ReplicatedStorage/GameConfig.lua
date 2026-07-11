--[[
	GameConfig.lua
	Shared configuration for "Set Sail: Cruise Line 2026"
	Place under ReplicatedStorage.
]]

local GameConfig = {}

GameConfig.GameName = "Set Sail: Cruise Line"
GameConfig.LaunchYear = 2026
GameConfig.TeaserMessage = "🚢 COMING 2026 🚢"

-- Coin rewards for activities around the ship
GameConfig.Rewards = {
	BuffetTip = 5,
	CasinoWinMin = 10,
	CasinoWinMax = 50,
	PoolMiniGame = 15,
	DockingBonus = 100,
	DailyLogin = 25,
}

-- Decks available on the cruise ship (unlockable with coins as players progress)
GameConfig.Decks = {
	{ Name = "Main Deck",       UnlockCost = 0 },
	{ Name = "Pool Deck",       UnlockCost = 250 },
	{ Name = "Casino Deck",     UnlockCost = 500 },
	{ Name = "Buffet Deck",     UnlockCost = 750 },
	{ Name = "Captain's Bridge",UnlockCost = 1500 },
	{ Name = "Luxury Suites",   UnlockCost = 3000 },
}

-- Ports of call the ship can dock at (rotates on a timer)
GameConfig.Ports = {
	"Sunset Harbor",
	"Coral Bay",
	"Frostpine Fjord",
	"Palm Isle",
	"Neon City Docks",
}

GameConfig.PortRotationSeconds = 60 * 20 -- ship "arrives" at a new port every 20 minutes

return GameConfig
