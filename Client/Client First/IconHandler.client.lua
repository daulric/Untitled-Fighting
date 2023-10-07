local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)
local controllers = devbox.controllers

local UserStatsSelection = controllers.GetController("UserSS")
local SettingsController = controllers.GetController("Settings Controller")


local Icon = require(ReplicatedStorage:WaitForChild("SystemPackages").Icon)

repeat task.wait(1) until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All) == true

local userStatsIcon = Icon.new()
local userSettingsIcon = Icon.new()

userStatsIcon:setImage("http://www.roblox.com/asset/?id=6022668898")
userStatsIcon:setCaption("Stats")

userSettingsIcon:setImage()
userSettingsIcon:setCaption("Settings")

userStatsIcon:bindEvent("selected", function(element)
	UserStatsSelection:SendSignal("select")
end)

userStatsIcon:bindEvent("deselected", function(element)
	UserStatsSelection:SendSignal("deselect")
end)

local dropdownIcon = Icon.new()
dropdownIcon:setDropdown({
    userStatsIcon,
    userSettingsIcon,
})