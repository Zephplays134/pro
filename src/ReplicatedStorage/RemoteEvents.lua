--[[
	RemoteEvents.lua
	Creates (or fetches) all RemoteEvents/RemoteFunctions used by the game,
	so server and client scripts can require this same module safely.
	Place under ReplicatedStorage.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local folder = ReplicatedStorage:FindFirstChild("CruiseRemotes")
if not folder then
	folder = Instance.new("Folder")
	folder.Name = "CruiseRemotes"
	folder.Parent = ReplicatedStorage
end

local function getOrCreate(className, name)
	local existing = folder:FindFirstChild(name)
	if existing then
		return existing
	end
	local inst = Instance.new(className)
	inst.Name = name
	inst.Parent = folder
	return inst
end

local RemoteEvents = {
	UpdateCoins        = getOrCreate("RemoteEvent", "UpdateCoins"),
	UnlockDeck         = getOrCreate("RemoteEvent", "UnlockDeck"),
	PortArrived        = getOrCreate("RemoteEvent", "PortArrived"),
	PlayMiniGameResult = getOrCreate("RemoteEvent", "PlayMiniGameResult"),
	RequestDock        = getOrCreate("RemoteFunction", "RequestDock"),
}

return RemoteEvents
