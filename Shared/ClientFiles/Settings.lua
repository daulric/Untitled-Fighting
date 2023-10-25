local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage.Packages:WaitForChild("devbox"))

local Settings = ReplicatedStorage:WaitForChild("Settings")

local oneframe = devbox.oneframe

local comp = oneframe.Component:extend("New Settings")

function changeShadow(obj)
    obj:GetPropertyChangedSignal("Value"):Connect(function()
        for i, part: Part in pairs(workspace:GetDescendants()) do
            if part:IsA("Part") then
                part.CastShadow = obj.Value
            end
        end
    end)
end

function comp:render()
    for i, obj in pairs(Settings:GetChildren()) do
        if obj.Name == "Shadow" then
            changeShadow(obj)
        end
    end
end

return comp