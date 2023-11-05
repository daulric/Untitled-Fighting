local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local Component, createElement  = exon.import(exon.react) {
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