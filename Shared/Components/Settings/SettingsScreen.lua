--[[
    This is the Settings Screen For Untitled Fighting
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local react = devbox.react

local Component = react.Component:extend("Settings Screen")

local SettFrame = require(script.Parent:WaitForChild("SettingsFrame"))

function Component:render()
    return react.createElement("ScreenGui", {
        Name = "Settings Screen",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
    }, {
        SettingsFrame = react.createElement(SettFrame, {}, {

            UICorner = react.createElement("UICorner", {
                Name = "Corner",
                CornerRadius = UDim.new(0, 4),
            }),

            TextLabel = react.createElement("TextLabel", {
                Name = "Text",
                Text = "Settings",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Position = UDim2.new(0.333, 0,0, 0),
                Size = UDim2.new(0.333, 0, 0.124, 0),
                TextScaled = true,
                BackgroundTransparency = 1,
                Font = Enum.Font.Cartoon,
            })



        })
    })
end

return Component