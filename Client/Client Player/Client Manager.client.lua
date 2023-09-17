local RS = game:GetService("ReplicatedStorage")
local Packages = RS:WaitForChild("Packages")

local devbox = require(Packages:WaitForChild("devbox"))

local OneFrame = devbox.oneframe
local Controllers = devbox.controllers

OneFrame.Settings.ignorePrint = true

local player = game.Players.LocalPlayer

local ControllersFolder = RS.Shared:WaitForChild("Controllers")

Controllers.AddController(ControllersFolder)

local ClientFiles = RS.Shared:WaitForChild("ClientFiles")

local StatusScreen = require(RS.Shared:WaitForChild("Components").Status.StatusScreen)
local NewUST = RS.Shared:WaitForChild("Components").UserStats

local UserStatsScreen = require(NewUST:WaitForChild("UserStatsScreen"))

local mount, createElement = devbox.import(devbox.react) {
	"mount", "createElement"
}


function startClient()

	OneFrame.Start(ClientFiles):andThenCall(OneFrame.Promise.delay, 2) :andThen(function()
		OneFrame.Start(player.PlayerGui):andThenCall(OneFrame.Promise.delay, 1):andThen(function()
			player:SetAttribute("Loaded", true)
			print("Client Loaded!")
		end)
	end)
end

function startMount()
	mount(
		createElement(StatusScreen, {
			player = player
		}),
		player.PlayerGui
	)

	mount(
		createElement(UserStatsScreen),
		player.PlayerGui
	)
end

startClient()
startMount()