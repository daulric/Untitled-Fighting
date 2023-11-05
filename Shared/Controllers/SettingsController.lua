local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages.exon)

local controllers = exon.controllers
local rednet = exon.rednet

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