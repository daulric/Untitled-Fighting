local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local oneframe = devbox.oneframe

local LTM = oneframe.Component:extend("Lobby Team Manager")

local connections = {}

function LTM:render()

    local function teamAdded(player: Player)
        task.wait(1)
        local character = player.Character or player.CharacterAdded:Wait()

        local connection = character.Humanoid.HealthChanged:Connect(function(health)
            character.Humanoid.Health = 100
        end)

        connections[player.Name] = connection
    end

    local function teamRemoved(player: Player)
        if connections[player.Name] then
            connections[player.Name]:Disconnect()
        end
    end

    Teams.Lobby.PlayerAdded:Connect(teamAdded)
    Teams.Lobby.PlayerRemoved:Connect(teamRemoved)

end

return LTM