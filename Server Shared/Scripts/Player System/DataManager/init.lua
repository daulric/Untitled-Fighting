local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local exon = require(Packages:WaitForChild("exon"))

local OneFrame = exon.oneframe
local Controllers = exon.controllers
local react = exon.react
local util = exon.util

local RoDB = exon.rodb

local DataManager = OneFrame.Component:extend("Player Data Manager")

local leaderstatsComponent = require(script:WaitForChild("leaderstatsComponent"))

local Profiles = {}

function ManageLevel(leaderstats)
	local xp = leaderstats:GetAttribute("Xp")
	local requiredXp = leaderstats:GetAttribute("RequiredXp")
	local level = leaderstats:GetAttribute("Level")

	if xp >= requiredXp then
		leaderstats:SetAttribute("Xp", 0)
		leaderstats:SetAttribute("Level", level + 1)

		local newLevel = leaderstats:GetAttribute("Level")
		leaderstats:SetAttribute("RequiredXp", newLevel * 100)
	end

end

local function playerAdded(self, player: Player)

	local profile = RoDB.LoadProfile("Player Database", player.UserId, {
		Kills = 0,
		Deaths = 0,
		Bits = 0,

		Level = 1,
		Xp = 0,
		RequiredXp = 100,
	})

	Profiles[player.UserId] = profile

	local Folder = Instance.new("Folder", player)
	Folder.Name = "leaderstats"

	local leaderstatsElement = react.createElement(leaderstatsComponent)
	react.mount(leaderstatsElement, Folder)

	profile:Reconcile()

	util.iterate(profile.data, function(index, value)
		Folder:SetAttribute(index, value)
	end)

	self.Cleanup:Connect(Folder.AttributeChanged, function(name)

		if tostring(name):lower() == "xp" then
			self.state.ManageLevel(Folder)
		end

		profile.data[name] = Folder:GetAttribute(name)
	end)

end

local function playerRemoving(self, player: Player)
	Profiles[player.UserId]:Save()
	Profiles[player.UserId] = nil
end

function DataManager:preload()
	self:setState({
		playerAdded = playerAdded,
		playerRemoving = playerRemoving,
		
		ManageLevel = ManageLevel
	})
end

function DataManager:start()

	self.Cleanup:Connect(Players.PlayerAdded, function(player)
		self.state.playerAdded(self, player)
	end)

	self.Cleanup:Connect(Players.PlayerRemoving, function(player)
		self.state.playerRemoving(self, player)
	end)

end

function DataManager:closing()
	self.Cleanup:Clean()

	util.iterate(Profiles, function(index, profile)
		profile:Save()
		profile:Close()
		Profiles[index] = nil
	end)

end

return DataManager