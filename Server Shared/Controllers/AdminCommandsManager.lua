local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local controllers = devbox.controllers

local ACM = controllers.CreateController {
    Name = "Admin Command Manager",
    RegisteredCommands = {}
}

function ACM:add(command)
    if table.find(self.RegisteredCommands, `!{command}`) then
        return
    end

    table.insert(self.RegisteredCommands, `!{command}`)
end

function ACM:get()
    return self.RegisteredCommands
end

return ACM