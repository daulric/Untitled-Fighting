--[[
    This is the Settings Screen For Untitled Fighting
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local react = exon.react

local Component = react.Component:extend("Settings Screen")

local SettFrame = require(script.Parent:WaitForChild("SettingsFrame"))
local ScrollingFrame = require(script.Parent:WaitForChild("SettingScrollingFrame"))

local TempFiles = script.Parent:WaitForChild("Temp")
local createTempBar = require(TempFiles:WaitForChild("CreateTempBar"))

function Component:render()
    return react.createElement("ScreenGui", {
        Name = "Settings Screen",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
    }, {
        SettingsFrame = react.createElement(SettFrame, {}, {

            TextLabel = react.createElement("TextLabel", {
                Name = "Text",
                Text = "Settings",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Position = UDim2.new(0.333, 0,0, 0),
                Size = UDim2.new(0.333, 0, 0.124, 0),
                TextScaled = true,
                BackgroundTransparency = 1,
                Font = Enum.Font.Cartoon,
            }),

            ScrollingFrame = react.createElement(ScrollingFrame, {}, {

                UIList = react.createElement("UIListLayout", {
                    Name = "UI List",
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 4)
                }),

                ShadowSettings = react.createElement(createTempBar, {
                    Name = "Shadow",
                    Type = "Toggle",
                    execute = function(obj, update, element)
                        update(not obj.Value)
                    end
                }),

                FOVSettings = react.createElement(createTempBar, {
                    Name = "FOV",
                    Type = "Input",
                    execute = function(_, update, isKeyDown, element)
                        if isKeyDown(Enum.KeyCode.Return) then
                            update(element.Text)
                        end
                    end
                })

                
            }),

        })
    })
end

return Component