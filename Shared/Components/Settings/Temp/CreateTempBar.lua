local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage.Packages:WaitForChild("devbox"))


local react = devbox.react

local Component = react.Component:extend("CreateSettingBar")

local TempTypes = script.Parent:WaitForChild("Types")

local TempFrame = require(script.Parent:WaitForChild("TempFrame"))
local Toggle = require(TempTypes:WaitForChild("Toggle"))
local Input = require(TempTypes:WaitForChild("Input"))

type SettingType = {
    execute: () -> (),
    name: string,
}

function Component:init()
    self.chooseType, self.updateType = react.createBinding(Toggle)
end

function Component:didMount()
    if self.props.Type == "Toggle" then
        self.updateType(Toggle)
    elseif self.props.Type == "Input" then
        self.updateType(Input)
    end
end

function Component:render()

    local newElement

    if self.props.Type == "Toggle" then
        newElement = Toggle
    elseif self.props.Type == "Input" then
        newElement = Input
    end

    return react.createElement(TempFrame, {
        Name = self.props.Name,
    }, {
        InputType = react.createElement(newElement, {
            name = self.props.Name,
            execute = self.props.execute,
        })
    })
end

return Component