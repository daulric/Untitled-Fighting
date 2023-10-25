local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Icon = require(ReplicatedStorage:WaitForChild("SystemPackages").Icon)

repeat task.wait(1) until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All) == true

local Icons = script.Parent:WaitForChild("Icons")

local SettingIcon = require(Icons:WaitForChild("SettingIcon"))
local UserStatsIcon = require(Icons:WaitForChild("UserStatsIcon"))

local dropdownIcon = Icon.new()
dropdownIcon:setImage("http://www.roblox.com/asset/?id=6031091004")

dropdownIcon.selected:Connect(function()
    dropdownIcon:setImage("http://www.roblox.com/asset/?id=6031090990")
end)

dropdownIcon.deselected:Connect(function()
    dropdownIcon:setImage("http://www.roblox.com/asset/?id=6031091004")
end)

dropdownIcon:setDropdown({
    UserStatsIcon,
    SettingIcon,
})