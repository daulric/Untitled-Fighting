local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local react = exon.react

local Settings = game.ReplicatedStorage:WaitForChild("Settings")

local InputComponent = react.Component:extend("Input Setting Component")

function InputComponent:init()
    self.settingRef = react.createRef()
    self.textbox = react.createRef()
    self.textValue, self.updateTextValue = react.createBinding("")
end

function InputComponent.IsKeyDown(key: Enum.KeyCode, gamePadNum: Enum.UserInputType?)

    if UserInputService.KeyboardEnabled then
        return UserInputService:IsKeyDown(key)
    elseif UserInputService.GamepadConnected then
        return UserInputService:IsGamepadButtonDown(gamePadNum, key)
    end

end

function InputComponent:render()
    return react.createElement("TextBox", {
        [react.Ref] = self.textbox,

        Name = self.props.name,
        PlaceholderText = "Enter Value",
        Text = "",

        PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(32, 32, 32),
        TextColor3 = Color3.fromRGB(255, 255, 255),

        Size = UDim2.new(0.234, 0, 0.609, 0),
        Position = UDim2.new(0.747, 0, 0.19, 0),
        ClearTextOnFocus = true,

        [react.Event.ReturnPressedFromOnScreenKeyboard] = function(element: TextBox)
            if self.props.execute == nil or type(self.props.execute) ~= "function" then
                error(`there is not execute function in props; we got {type(self.props.execute)}`)
            end

            local settingRef = self.settingRef:getValue()
            self.props.execute(settingRef, self.updateTextValue, self.IsKeyDown, element)
        end,

    }, self.props[react.Children], {

        UICorner = react.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4)
        }),

        Settings = react.createElement(react.Gateway, {
            path = Settings
        }, {
            StringVal = react.createElement("StringValue", {
                [react.Ref] = self.settingRef,
                Name = self.props.name,

                Value = self.textValue:map(function(value)
                    if value == nil then
                        value = ""
                    end

                    return value
                end),

            })
        })
    })
end

return InputComponent