local ReplicatedStorage = game:GetService("ReplicatedStorage")

local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)
local Settings = ReplicatedStorage.Settings

local react = exon.react
local rednet = exon.rednet

local Component = react.Component:extend("Setting Toggle")

function Component:init()
    self.settingRef = react.createRef()
    self.toggle, self.updateToggle = react.createBinding(false)
    self.color, self.updateColor = react.createBinding(false)
    self.Text, self.updateText = react.createBinding("Disabled")

    self.colorBool = {
        [false] = {
            Text = "Disabled",
            Color = Color3.fromRGB(109, 8, 8)
        },
        [true] = {
            Text = "Enabled",
            Color = Color3.fromRGB(34, 117, 62)
        }
    }
end

function Component:render()
    return react.createElement("TextButton", {
        Name = "Toggle Setting Button",
        Size = UDim2.new(0.234, 0, 0.609, 0),
        TextScaled = true,
        Position = UDim2.new(0.747, 0, 0.19, 0),
        BackgroundColor3 = self.color:map(function(value)

            local val = self.colorBool[value]
            self.updateText(val.Text)

            return val.Color
        end),
        Text = self.Text:map(function(value)
            return value
        end),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.Creepster,

        [react.Event.MouseButton1Click] = function(element: TextButton)

            if self.props.execute == nil or type(self.props.execute) ~= "function" then
                error(`there is not execute function in props; we got {type(self.props.execute)}`)
            end

            local setting = self.settingRef:getValue()
            self.props.execute(setting, self.updateToggle, element)
        end,
    }, self.props[react.Children], {
 
        UICorner = react.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4)
        }),

        Settings = react.createElement(react.Gateway, {
            path = Settings,
        }, {
            Default = react.createElement("BoolValue", {
                [react.Ref] = self.settingRef,
                Name = self.props.name,
                Value = self.toggle:map(function(value)
                    if value == nil or type(value) ~= "boolean" then
                        return false
                    end

                    self.updateColor(value)
                    return value
                end),

                [react.Change.Value] = function(_)
                    local newVal = self.settingRef:getValue()
                    self.updateColor(newVal.Value)
                end
            }),
        })

    })
end

return Component