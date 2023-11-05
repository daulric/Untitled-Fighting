local ReplicatedStorage = game:GetService("ReplicatedStorage")

local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local react = exon.react

local Component = react.Component:extend("Settings Temp Frame")

function Component:render()
    return react.createElement("Frame", {
        Name = self.props.Name,
        Size = UDim2.new(0.95, 0, 0.06, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(45, 56, 58),
    }, self.props[react.Children], {

        TextLabel = react.createElement("TextLabel", {
            Name = self.props.Name,
            Text = self.props.Name,
            Size = UDim2.new(0.5, 0, 1, 0 ),
            Position = UDim2.new(0.068, 0, 0, 0 ),
            BackgroundTransparency = 1,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }),

        UICorner = react.createElement("UICorner", {
            Name = "Corner Radius",
            CornerRadius = UDim.new(0, 4)
        }),

    })
end

return Component