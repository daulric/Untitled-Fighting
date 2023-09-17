local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local Component, createBinding, createElement, createFragment, Ref = devbox.import(devbox.react) {
    "Component", "createBinding", "createElement", "createFragment", "Ref"
}

local TextFrame = Component:extend("UserStats TextLabel")

function TextFrame:render()
    return createElement("Frame", {
        Name = "StatsFrame",
        Size = UDim2.new(0.9, 0, 1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.1, 0,0, 0)
    }, {
        Text = createElement("TextLabel", {
            Name = "TextLabel",
            Text = self.props.Text,
            RichText = true,
            Size = UDim2.new(1, 0, 1, 0),
            TextColor3 = Color3.fromRGB(30, 30, 30),
            BackgroundTransparency = 1,
            TextScaled = true,
        })
    })
end

return TextFrame