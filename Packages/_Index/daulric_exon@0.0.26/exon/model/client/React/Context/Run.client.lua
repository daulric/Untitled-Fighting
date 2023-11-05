local Players = game:GetService("Players")
local exon = require(game.ReplicatedStorage.exon)
local react = exon.react

local ThemeController = require(script.Parent:WaitForChild("ThemeController"))
local Button = require(script.Parent:WaitForChild("Button"))

local handle

local element = react.createElement(ThemeController, {}, {
    ScreenGui = react.createElement("ScreenGui", {
        Name = "react Context",
        IgnoreGuiInset = true,
    }, {
        Button = react.createElement(Button),
    })
})

handle = react.mount(element, Players.LocalPlayer.PlayerGui)

task.wait(10)
handle = react.update(handle, element)
print("Updating", script.Parent.Name, "react")