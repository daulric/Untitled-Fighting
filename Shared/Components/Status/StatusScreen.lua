local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatusFolder = script.Parent

local StatusText = require(StatusFolder:WaitForChild("Status"))
local StatusFrame = require(StatusFolder:WaitForChild("StatusBar"))

local devbox = require(ReplicatedStorage.Packages:WaitForChild("devbox"))

local Component, createElement = devbox.import(devbox.react) {
    "Component", "createElement"
}

local SScreen = Component:extend("Status Screen")

function SScreen:render()
    return createElement("ScreenGui", {
        Name = "Status",
        IgnoreGuiInset = true,
    }, {
        StatusFrame = createElement(StatusFrame, {}, {
            StatusText = createElement(StatusText, {
                player = self.props.player
            }),
        })
    })
end

return SScreen