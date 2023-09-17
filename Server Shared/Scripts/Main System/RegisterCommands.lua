local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local Controllers = devbox.controllers
local ACM = Controllers.GetController("Admin Command Manager")

function AddCommand(command)
    ACM:add(command)
end

return function (render)
    render(function()
        AddCommand("kick")
    end)
end