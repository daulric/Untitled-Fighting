local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = game:GetService("ReplicatedStorage").Packages

local devbox = require(Packages:WaitForChild("devbox"))

local oneframe = devbox.oneframe
local Controllers = devbox.controllers
local rednet = devbox.rednet

local ServerStorage = game:GetService("ServerStorage")
local ScriptsFolder = ServerStorage.Shared:WaitForChild("Scripts")
local AdminAccess = ServerStorage.Shared:WaitForChild("AdminCommands")

local ControllerFolder = ReplicatedStorage.Shared:WaitForChild("Controllers")
local ServerControllers = ServerStorage:WaitForChild("Shared"):WaitForChild("Controllers")

Controllers.AddController(ControllerFolder)
Controllers.AddController(ServerControllers)

local ACM = Controllers.GetController("Admin Command Manager")

oneframe.Start(ScriptsFolder):andThen(function()
	print("Server Loaded!")
end)

game.Players.PlayerAdded:Connect(function(player)
	local prefix = "!"
	player:SetAttribute("AFK", true)

	player.Chatted:Connect(function(message)
		if player:GetRankInGroup(12852480) >= 100 then

			local match1 = string.split(message, " ")
			local match = table.find(ACM:get(), match1)

			local ifCommand = false

			for i, command in pairs(ACM:get()) do
				if string.find(message, command) then
					ifCommand = true
					break
				end
			end

			if ifCommand == true then
				oneframe.Settings.ignorePrint = true
				oneframe.Start(AdminAccess, player, message, prefix):andThen(function()
					print("Command Valid :", "Executing Command")
					oneframe.Settings.ignorePrint = false
				end)
			end

		end

	end)

end)

rednet.listen("afk", function(player: Player, bool)
	if bool == false then
		player:SetAttribute("AFK", false)
	end
end)