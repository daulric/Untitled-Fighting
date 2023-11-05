local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local Component, createBinding, createElement, Ref, Children, createRef, Event, Change = exon.import(exon.react) {
    "Component", "createBinding", "createElement", "Ref", "Children", "createRef", "Event", "Change"
}

local UserStatsScroll = Component:extend("User Stats Scrolling Frame")


function UserStatsScroll:render()

    return createElement("ScrollingFrame", {
        Name = "Scroll",
        Size = UDim2.new(1, 0, 0.875, 0),
        Position = UDim2.new(0, 0 ,0.124, 0 ),

        ScrollingEnabled = true,
        ClipsDescendants = true,

        CanvasSize = UDim2.new(0, 0, 2, 0 ),
        ScrollBarThickness = 4,
        ScrollingDirection = Enum.ScrollingDirection.XY,

        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(30, 30, 30),

    }, self.props[Children])
end

return UserStatsScroll