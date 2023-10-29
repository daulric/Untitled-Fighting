local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage.Packages:WaitForChild("devbox"))

local rodb = devbox.rodb
local oneframe = devbox.oneframe
local rednet = devbox.rednet

local comp = oneframe.Component:extend("Settings Database")

local dataLogs = {}

function playerAdded(player: Player)
    local db = rodb.create("Player Settings Database", player)
    dataLogs[player] = db

    db:Retrieve()

    local data = db.data

    if data == nil then
        data = {}
    end

    rednet:FireClient(player, "settings retrieval", data)
end

function comp:start()

    self.Cleanup:Connect(Players.PlayerAdded, playerAdded)
    self.Cleanup:Connect(Players.PlayerRemoving, function(player)
        local db = dataLogs[player]
        db:Save()
        dataLogs[player] = nil
    end)

    rednet.listen("settings save data", function(player, incomingIndex, incomingValue)
        local db = dataLogs[player]
        db.data[incomingIndex] = incomingValue
        db:Save()
    end)
end

function comp:closing()
   self.Cleanup:Clean() 
end

return comp