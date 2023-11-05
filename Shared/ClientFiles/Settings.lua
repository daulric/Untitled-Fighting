local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local Settings = ReplicatedStorage:WaitForChild("Settings")

local oneframe = exon.oneframe
local rednet = exon.rednet

local comp = oneframe.Component:extend("New Settings")

function SaveSettingsData(obj)
    rednet:FireServer("settings save data", obj.Name, obj.Value)
end

function changeShadow(obj)

    for i, part: Part in pairs(workspace:GetDescendants()) do
            if part:IsA("Part") then
                part.CastShadow = obj.Value
            end
    end

end

function changeFOV(obj)
    local camera = workspace.CurrentCamera
    camera.FieldOfView = tonumber(obj.Value)
end

function comp:start()

    local data = {}

    rednet.listen("settings retrieval", function(data)

        for i, v in pairs(data) do

            if Settings[i] ~= nil then
                Settings[i].Value = v
            end

        end

    end)

    for i, obj in pairs(Settings:GetChildren()) do

        obj:GetPropertyChangedSignal("Value"):Connect(function()
            if obj.Name == "Shadow" then
                changeShadow(obj)
            end

            if obj.Name == "FOV" then
                changeFOV(obj)
            end

            SaveSettingsData(obj)
        end)

    end
end

return comp