local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local devbox = require(Packages:WaitForChild("devbox"))

local OneFrame = devbox.oneframe
local Util = devbox.util

local PD = OneFrame.Component:extend("Player Died Manager")

function PlayerAdded(player: Player)

	local leaderstats = player:WaitForChild("leaderstats", 10)
	player:SetAttribute("KillsBeforeDeath", 0)

	PD.Cleanup:Connect(player.CharacterAdded, function(char)
		local humanoid = char:WaitForChild("Humanoid")

		PD.Cleanup:Connect(humanoid.Died, function()
			
			player:SetAttribute("KillsBeforeDeath", 0)

			if player.Team == Teams.Contestants then
				leaderstats:SetAttribute("Deaths", leaderstats:GetAttribute("Deaths") + 1)
			end

			local creator = humanoid:FindFirstChild("creator")

			if creator ~= nil and creator.Value ~= nil then
				local killerleaderstats = creator.Value:FindFirstChild("leaderstats")

				local lastKills = killerleaderstats:GetAttribute("Kills")
				local last_kbd = creator.Value:GetAttribute("KillsBeforeDeath")

				killerleaderstats:SetAttribute("Kills", (lastKills + 1))
				creator.Value:SetAttribute("KillsBeforeDeath", last_kbd + 1)
			end

		end)

	end)
end

function PD:preload()
	PD:setState({
		playerAdded= PlayerAdded
	})
end

function PD:start()

	Util.iterate(Players:GetPlayers(), function(_, player)
		PD.state.playerAdded(player)
	end)

	PD.Cleanup:Connect(Players.PlayerAdded, PD.state.playerAdded)
end

function PD:closing()
	PD.Cleanup:Clean()
end

return PD