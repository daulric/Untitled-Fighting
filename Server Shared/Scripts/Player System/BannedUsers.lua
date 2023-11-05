local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local exon = require(Packages:WaitForChild("exon"))

local oneframe = exon.oneframe
local RoDB = exon.rodb
local RedNet = exon.rednet

local Banned = oneframe.Component:extend("Banned Users")

local Profiles = {}
local SecondsInADay = 86400

function playerAdded(player: Player)
	local profile = RoDB.create("Banned Users Database", player, {
		banned = false,
		reason = "",
		timeRemaining = 0,
		days = 0,
	})
	
	Profiles[player.UserId] = profile

	profile:Retrieve()
	
	if profile.data.banned == true and profile.data.timeRemaining ~= 0 then
		
		local newTime = os.time()
		
		local currentTimeRemaining = (profile.data.timeRemaining - newTime)

		local DaysRemaining = math.floor((currentTimeRemaining / SecondsInADay))
		print(DaysRemaining, "days remaining until", player.Name, "is unbanned!")

		if DaysRemaining > 1 then
			profile.data.timeRemaining = os.time()
			profile.data.days = DaysRemaining
			profile:Save()

			player:Kick(`Currently Banned For {profile.data.days} Days For {profile.data.reason}`)
		else
			profile.data  = table.clone(profile.template)
			profile:Save()
		end

	end

end

function playerRemoved(player: Player)
	local profile = Profiles[player.UserId]
	if profile ~= nil then
		profile:Save()
		Profiles[player.UserId] = nil
	end
end

function Banned:preload()

	self.playerAdded = playerAdded
	self.playerRemoved = playerRemoved

end

function Banned:start()

	self.Cleanup:Connect(Players.PlayerAdded, self.playerAdded)
	self.Cleanup:Connect(Players.PlayerRemoving, self.playerRemoved)
	
	RedNet.listen("detector", function(player: Player, banned, reason, days)
		if RunService:IsStudio() then
			-- Due To Testing a Debugging,we need to avoid triggering false positives
			return
		end

		local profile = Profiles[player.UserId]
		
		if banned == true then
			if reason == nil or string.len(reason) <= 1 then
				reason = "No Reason Provided!"
			end
			
			if days == nil or days == 0 then
				days = 1
			end

			local daysinUnix = SecondsInADay * days
			
			profile.data.banned = banned
			profile.data.reason = reason
			profile.data.timeRemaining = os.time() + daysinUnix
			profile.data.days = days
			
			local BannedTime = profile.data.timeRemaining
			
			profile:Save()
			player:Kick(`Banned For {profile.data.days} Days For {profile.data.reason}`)
		end

	end)

end

function Banned:closing()
	for i, profile in pairs(Profiles) do
		profile:Save()
		Profiles[i] = nil
	end
	
	self.Cleanup:Clean()
end

return Banned