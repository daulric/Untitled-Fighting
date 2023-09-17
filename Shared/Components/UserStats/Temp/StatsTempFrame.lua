local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local Component, createElement, createFragment, Children = devbox.import(devbox.react) {
    "Component", "createElement", "createFragment", "Children"
}

function AddChildren(props)
    return createFragment({
        UICorner = react.createElement("UICorner", {
			Name = "Corner",
			CornerRadius = UDim.new(0,4)
		}),
		
		UIGradient = react.createElement("UIGradient", {
			Name = "Gradient",
			Color = props.gradient
		})
    })
end

local STF = Component:extend("Status Template Frame")

function STF:render()
	return createElement("Frame", {
		Name = "Stat",
		Size = UDim2.new(0.9, 0, 0.05, 0),
	}, self.props[Children])
end

return STF