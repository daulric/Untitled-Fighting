local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local react = exon.react

local Component = react.Component:extend("Settings ScrollingFrame")

function Component:render()
    return react.createElement("ScrollingFrame", {
        Name = "Setting Scrolling Frame",
        Size = UDim2.new(1, 0, 0.86, 0),
        Position = UDim2.new(0, 0, 0.138, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 5,
    }, self.props[react.Children])
end

return Component