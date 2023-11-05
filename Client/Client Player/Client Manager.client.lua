local RS = game:GetService("ReplicatedStorage")
local Packages = RS:WaitForChild("Packages")

local exon = require(Packages:WaitForChild("exon"))

local OneFrame = exon.oneframe
local Controllers = exon.controllers

OneFrame.Settings.ignorePrint = true

local player = game.Players.LocalPlayer

local ControllersFolder = RS.Shared:WaitForChild("Controllers")

Controllers.AddController(ControllersFolder)

local ClientFiles = RS.Shared:WaitForChild("ClientFiles")

local StatusScreen = require(RS.Shared:WaitForChild("Components").Status.StatusScreen)
local SettingsScreen = require(RS.Shared.Components.Settings.SettingsScreen)
local NewUST = RS.Shared:WaitForChild("Components").UserStats

local UserStatsScreen = require(NewUST:WaitForChild("UserStatsScreen"))

local mount, createElement = exon.import(exon.react) {
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

	mount(
		createElement(SettingsScreen),
		player.PlayerGui
	)
end

startClient()
startMount()