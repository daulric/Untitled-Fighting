local ReplicatedStorage = game:GetService("ReplicatedStorage")

local devbox = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("devbox"))

local Component, createBinding, createElement, Children, createFragment = devbox.import(devbox.react) {
    "Component", "createBinding", "createElement", "Children", "createFragment"
}

local bar = Component:extend("Status Bar")

function bar:init()
    self.gradColor, self.updateGradColor = createBinding(ColorSequence.new(Color3.fromRGB(0,0,0)))
end

function bar:didMount()
    self.updateGradColor(Color3.fromRGB(186, 13, 13))
end

function bar:render()
    return createElement("Frame", {
        Size = UDim2.new(0.239, 0,0.092, 0),
        SizeConstraint = Enum.SizeConstraint.RelativeXY,
        Visible = true,
        Position = UDim2.new(0.38, 0, -0.001, 0),
        ZIndex = 1,
        BackgroundColor3 = Color3.fromRGB(74, 16, 16),
        BorderColor3 = Color3.fromRGB(0,0,0),
    }, {
        createFragment(self.props[Children]),

        UICorner = createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        })
    }

)
end

return bar