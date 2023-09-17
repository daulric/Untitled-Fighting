local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local SysPackages = ReplicatedStorage:WaitForChild("SystemPackages")

local devbox = require(Packages:WaitForChild("devbox"))
local ZonePlus = require(SysPackages:WaitForChild("ZonePlus"))

local oneframe = devbox.oneframe

local ZM = oneframe.Component:extend("Zone Manager")

function ZM:render()
    local area = workspace:WaitForChild("Arena"):WaitForChild("ForceField")
    local zone = ZonePlus.new(area)

    zone.playerEntered:Connect(function(player)
        player.Team = Teams.Contestants
    end)

    zone.playerExited:Connect(function(player)
        player.Team = Teams.Lobby
    end)
end

return ZM