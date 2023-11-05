local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScriptContext = game:GetService("ScriptContext")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local exon = require(Packages:WaitForChild("exon"))

local oneframe = exon.oneframe
local rednet = exon.rednet

local DetectorClient = oneframe.Component:extend("Detector Client")

function DetectorClient:start()
	DetectorClient.Cleanup:Connect(ScriptContext.Error, function(message, trace, instance)
		if instance == nil or instance.Parent == nil then
			rednet:FireServer("detector", true, "Script Injection", 30)
		end
	end)
end

return DetectorClient