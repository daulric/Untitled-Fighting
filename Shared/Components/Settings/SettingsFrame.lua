local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local react = devbox.react
local controllers = devbox.controllers

local Component = react.Component:extend("Settings Frame")
local SettingSignal = controllers.GetController("Settings Controller")

local defaultPos = UDim2.new(0.233, 0, 0.215, 0)
local movingPos = UDim2.new(0.233, 0, -0.700, 0)
local tInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

function Component:init()
    self.enabled, self.updateEnabled = react.createBinding(false)
    self.frameGet = react.createRef()
end

function tweenFrame(frame, props)
    local tween

    local success, err = pcall(function()
        tween = TweenService:Create(frame, tInfo, props)
    end)

    if success then
        return tween
    end
end

function Component:didMount()
    local frame: Frame = self.frameGet:getValue()

    self.frame = frame
    self.frame.Position = movingPos

    SettingSignal.event:Connect(function(Type)

		if Type == "select" then

			if self.enabled:getValue() == true then
				return
			end

            self.updateEnabled(true)

            tweenFrame(self.frame, {
                Position = defaultPos
            }):Play()
		end

		if Type == "deselect" then
			if self.enabled:getValue() == false then
				return
			end

            local tween = tweenFrame(self.frame, {
                Position = movingPos,
            })

            tween.Completed:Connect(function()
                self.updateEnabled(false)
            end)

			tween:Play()

		end

	end)

end

function Component:willUnmount()
    if self.tweenConnection then
        self.tweenConnection:Disconnect()
        self.tweenConnection = nil
    end
end

function Component:render()
    return react.createElement("Frame", {
        [react.Ref] = self.frameGet,
        Name = "Settings Frame",
        Size = UDim2.new(0.5, 0, 0.7, 0),
        Position = UDim2.new(0.233, 0, 0.215, 0),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    }, self.props[react.Children], {

        UICorner = react.createElement("UICorner", {
            Name = "Corner",
            CornerRadius = UDim.new(0, 4),
        }),

    })
end

return Component