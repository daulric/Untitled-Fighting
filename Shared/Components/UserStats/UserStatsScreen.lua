local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local react = devbox.react

local player = Players.LocalPlayer

local StatsFrame = require(script.Parent:WaitForChild("UserStatsFrame"))
local ScrollingFrame = require(script.Parent:WaitForChild("UserStatsScrollingFrame"))

local listofItems = require(script.Parent:WaitForChild("ListOfItems"))

local Component, createElement, Ref, Children = devbox.import(react) {
    "Component", "createElement", "Ref", "Children"
}

local USScreen = Component:extend("User Stats Screen")

function USScreen:init()
    self:setState({
        list = {}
    })
    self.bits, self.updateBits = react.createBinding(0)
end

function USScreen:didMount()

    self:setState(function(state)
        for i, v in pairs(listofItems) do
            table.insert(state.list, v)
        end

        return state
    end)

end

function USScreen:render()
    return createElement("ScreenGui", {
        Name = "UserStats",
        IgnoreGuiInset = true
    }, {
        StatsFrame = createElement(StatsFrame, {}, {

            UICorner = createElement("UICorner", {
                Name = "Corner",
                CornerRadius = UDim.new(0, 4)
            }),

            TextLabel = createElement("TextLabel", {
                Name = `Your Stats`,
                Text = "Your Stats",
                TextScaled = true,
                Size = UDim2.new(0.333, 0, 0.124, 0),
                Position = UDim2.new(0.333, 0,0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.Cartoon,
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }),

            ScrollingFrame = createElement(ScrollingFrame, {}, {

                UIList = createElement("UIListLayout", {
                    Name = "UIList",
                    Padding = UDim.new(0, 10),
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }),

                StatsList = react.createFragment(self.state.list)

            }),

        })
    })
end

return USScreen