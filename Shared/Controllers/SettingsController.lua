local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage.Packages.devbox)

local controllers = devbox.controllers
local rednet = devbox.rednet

local SC = controllers.CreateController {
    Name = "Settings Controller",
    event = rednet.createSignal(),
}

function SC:SendSignal(...)
    self.event:Fire(...)
end

function SC:Connect(handler)
    self.event:Connect(handler)
end

return SC