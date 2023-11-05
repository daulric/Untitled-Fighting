local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local Controllers = exon.controllers
local ACM = Controllers.GetController("Admin Command Manager")

function AddCommand(command)
    ACM:add(command)
end

return function (render)
    render(function()
        AddCommand("kick")
    end)
end