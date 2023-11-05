local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Icon = require(ReplicatedStorage:WaitForChild("SystemPackages").Icon)

local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local controllers = exon.controllers
local UserStatsSelection = controllers.GetController("UserSS")

local userStatsIcon = Icon.new()

userStatsIcon:setImage("http://www.roblox.com/asset/?id=6022668898")
userStatsIcon:setCaption("Stats")
userStatsIcon.deselectWhenOtherIconSelected = true

userStatsIcon.selected:Connect(function()
    UserStatsSelection:SendSignal("select")
end)

userStatsIcon.deselected:Connect(function()
    UserStatsSelection:SendSignal("deselect")
end)

return userStatsIcon