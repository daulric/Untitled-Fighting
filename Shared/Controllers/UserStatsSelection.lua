local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local devbox = require(Packages:WaitForChild("devbox"))

local rednet = devbox.rednet
local Controllers = devbox.controllers


local USS = Controllers.CreateController {
	Name = "UserSS",
	event = rednet.createSignal(),
}

function USS:SendSignal(...)
	self.event:Fire(...)
end

return USS