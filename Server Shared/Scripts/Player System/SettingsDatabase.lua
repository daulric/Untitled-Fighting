local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local rodb = exon.rodb
local oneframe = exon.oneframe
local rednet = exon.rednet

local comp = oneframe.Component:extend("Settings Database")

local dataLogs = {}

function playerAdded(player: Player)
    local profile = rodb.LoadProfile("Player Settings Database", player.UserId, {
        Shadow = false,
        FOV = 70,
    })

    dataLogs[player] = profile

    profile:Reconcile()

    local data = profile.data

    if data == nil then
        data = {}
    end

    -- // This is where we push the data to the client or player loacally!!!
    --rednet:FireClient(player, "settings retrieval", data)
end

function playerLeft(player: Player)
    local profile = dataLogs[player.UserId]

    if profile ~= nil then
        profile:Save()
        profile:Close()
        task.wait(2)
        dataLogs[player.UserId] = nil
    end

end

function comp:start()

    self.Cleanup:Connect(Players.PlayerAdded, playerAdded)
    self.Cleanup:Connect(Players.PlayerRemoving, playerLeft)

    rednet.listen("settings save data", function(player, incomingIndex, incomingValue)
        local db = dataLogs[player]
        db.data[incomingIndex] = incomingValue
        db:Save()
    end)
end

function comp:closing()
    for i, v in pairs(Players:GetPlayers()) do
        local profile = dataLogs[v.UserId]
        if profile ~= nil then
            profile:Save()
            profile:Close()
            task.wait(2)
            dataLogs[v.UserId] = nil
        end
        
    end

   self.Cleanup:Clean()
end

return comp