local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage.Packages:WaitForChild("devbox"))

local Settings = ReplicatedStorage:WaitForChild("Settings")

local oneframe = devbox.oneframe
local rednet = devbox.rednet

local comp = oneframe.Component:extend("New Settings")

function SaveSettingsData(obj)
    rednet:FireServer("settings save data", obj.Name, obj.Value)
end

function changeShadow(obj)
    obj:GetPropertyChangedSignal("Value"):Connect(function()
        for i, part: Part in pairs(workspace:GetDescendants()) do
            if part:IsA("Part") then
                part.CastShadow = obj.Value
            end
        end

        SaveSettingsData(obj)
    end)
end

function comp:start()

    rednet.listen("settings retrieval", function(data)

        for i, v in pairs(data) do

            if Settings[i] ~= nil then
                Settings[i].Value = v
            end

        end

    end)

    for i, obj in pairs(Settings:GetChildren()) do
        if obj.Name == "Shadow" then
            changeShadow(obj)
        end
    end
end

return comp