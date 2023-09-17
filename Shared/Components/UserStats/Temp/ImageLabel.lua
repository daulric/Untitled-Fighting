local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local Component, createElement  = devbox.import(devbox.react) {
    "Component", "createElement",
}

local ImageLabel = Component:extend("UserStats ImageLabel")

function ImageLabel:render()
    return createElement("ImageLabel", {
        Name = "Icon",
        Image = self.props.image,
        Size = UDim2.new(0.1, 0, 1, 0),
        BackgroundTransparency = 1,
    })
end

return ImageLabel