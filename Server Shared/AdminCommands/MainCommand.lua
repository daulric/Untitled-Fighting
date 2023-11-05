local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local OneFrame = exon.oneframe
local Util = exon.util
local RedNet = exon.rednet

local MCC = OneFrame.Component:extend("Main Command Component")

function MCC:kick(player: Player, message: string)

	local splitMsg = string.split(message, " ")

	local message2 = splitMsg[2]

	Util.iterate(Players:GetPlayers(), function(_, v: Player)
		if v.Name:lower():sub(1, #message2) == message2:lower() or v.DisplayName:lower():sub(1, #message) == message2:lower() then

			local reason = message:split(message2, " ")[2]

			if reason == nil or string.len(reason) <= 1 then
				reason = "There is no reason, but whatever it was, it must be very bad!"
			end

			if v ~= player then
				v:Kick(`You Got Kicked! : Reason {reason}`)
			else
				RedNet:FireClient(player, "acm_warn", "You Can't Kick Yourself!")
			end

		end
	end)

end

function MCC:start(player: Player, message: string, prefix: string)
	if string.find(message, "kick") then
		self:kick(player, message)
	end
end

return MCC