local ReplicatedStorage = game:GetService("ReplicatedStorage")

local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)
local Settings = ReplicatedStorage.Settings

local react = devbox.react
local rednet = devbox.rednet

local Component = react.Component:extend("Setting Toggle")

function Component:init()
    self.settingRef = react.createRef()
    self.toggle, self.updateToggle = react.createBinding(false)

    self.signal = rednet.createSignal()
end

function Component:extend()
    return react.createElement("TextButton", {
        Name = "Toggle Setting Button",
        Text = "",
        Size = UDim2.new(0.5, 0, 0.5, 0),
        TextScaled = true,

        [react.Event.MouseButton1Click] = function(element: TextButton)

            if self.props.execute == nil or type(self.props.execute) ~= "function" then
                error(`there is not execute function in props; we got {type(self.props.execute)}`)
            end

            local setting = self.settingRef:getValue()
            self.props.execute(setting, self.updateToggle, element)
        end,
    }, {
 
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

                    return value
                end),

                [react.Change.Value] = function(_)
                    local newVal = self.settingRef:getValue()
                    self.signal:Fire(newVal)
                    rednet:FireServer(self.props.name, newVal)
                end
            }),
        })

    })
end

return Component