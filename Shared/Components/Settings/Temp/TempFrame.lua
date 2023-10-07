local ReplicatedStorage = game:GetService("ReplicatedStorage")

local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local react = devbox.react


local Component = react.Component:extend("Settings Temp Frame")

function Component:render()
    return react.createElement("Frame", {
        Name = "Temp Setting Frame",
        Size = UDim2.new(1, 0, 1, -35),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(46, 79, 84),
    }, self.props[react.Children])
end

return Component