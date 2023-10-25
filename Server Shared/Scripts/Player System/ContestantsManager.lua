local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Teams = game:GetService("Teams")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local ContestantsTeam = Teams:WaitForChild("Contestants")

local devbox = require(Packages:WaitForChild("devbox"))

local oneframe = devbox.oneframe
local util = devbox.util
local Tools = ServerStorage:WaitForChild("Tools")

local CM = oneframe.Component:extend("Contestants Team Manager")

function CM:start()
	CM.Cleanup:Connect(ContestantsTeam.PlayerAdded, function(player: Player)

		util.iterate(Tools:GetChildren(), function(_, tool)
			if tool:IsA("Tool") then
				tool:Clone().Parent = player.Backpack
			end
		end)

		CM.Cleanup:Connect(player.Character:WaitForChild("Humanoid").Died, function()
			player.Team = Teams.Lobby
			player.Backpack:ClearAllChildren()
		end)

	end)

	CM.Cleanup:Connect(ContestantsTeam.PlayerRemoved, function(player: Player)
		player.Backpack:ClearAllChildren()

		local character = player.Character or player.CharacterAdded:Wait()

		util.iterate(character:GetChildren(), function(_, tool)
			if tool and tool:IsA("Tool") then
				tool:Destroy()
			end
		end)

	end)

end

function CM:closing()
	CM.Cleanup:Clean()
end

return CM