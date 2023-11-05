local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local exon = require(Packages:WaitForChild("exon"))

local rednet = exon.rednet
local Controllers = exon.controllers


local USS = Controllers.CreateController {
	Name = "UserSS",
	event = rednet.createSignal(),
}

function USS:SendSignal(...)
	self.event:Fire(...)
end

return USS