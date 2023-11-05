local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatusFolder = script.Parent

local StatusText = require(StatusFolder:WaitForChild("Status"))
local StatusFrame = require(StatusFolder:WaitForChild("StatusBar"))

local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local Component, createElement = exon.import(exon.react) {
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