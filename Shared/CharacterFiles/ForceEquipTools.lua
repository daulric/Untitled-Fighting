local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local oneframe  = require(Packages:WaitForChild("devbox")).oneframe

local fetChar = oneframe.Component:extend("Force Equip Tools")

function fetChar:start(char: Model, player: Player)
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	
	if player.Team == game.Teams.Lobby then
		return
	end
	
	repeat task.wait() until player.StarterGear:FindFirstChildOfClass("Tool")
	
	local tool = player.Backpack:FindFirstChildOfClass("Tool")
	humanoid:EquipTool(tool)

end

return fetChar