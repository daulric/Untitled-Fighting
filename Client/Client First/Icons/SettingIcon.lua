local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Icon = require(ReplicatedStorage:WaitForChild("SystemPackages").Icon)

local devbox = require(ReplicatedStorage.Packages:WaitForChild("devbox"))
local controllers = devbox.controllers

local SettingsController = controllers.GetController("Settings Controller")

local userSettingsIcon = Icon.new()
userSettingsIcon:setImage("http://www.roblox.com/asset/?id=6031280882")
userSettingsIcon:setCaption("Settings")
userSettingsIcon.deselectWhenOtherIconSelected = true

userSettingsIcon.selected:Connect(function()
    SettingsController:SendSignal("select")
end)

userSettingsIcon.deselected:Connect(function()
    SettingsController:SendSignal("deselect")
end)

return userSettingsIcon