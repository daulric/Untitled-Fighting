local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local react = devbox.react

local Component = react.Component:extend("Settings Frame")

function Component:render()
    return react.createElement("Frame", {
        Name = "Settings Frame",
        Size = UDim2.new(0.5, 0, 0.7, 0),
        Position = UDim2.new(0.233, 0, 0.215, 0),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    }, self.props[react.Children])
end

return Component