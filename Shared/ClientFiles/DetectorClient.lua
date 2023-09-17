local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScriptContext = game:GetService("ScriptContext")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local devbox = require(Packages:WaitForChild("devbox"))

local oneframe = devbox.oneframe
local rednet = devbox.rednet

local DetectorClient = oneframe.Component:extend("Detector Client")

function DetectorClient:render()
	DetectorClient.Cleanup:Connect(ScriptContext.Error, function(message, trace, instance)
		if instance == nil or instance.Parent == nil then
			rednet:FireServer("detector", true, "Script Injection", 30)
		end
	end)
end

return DetectorClient