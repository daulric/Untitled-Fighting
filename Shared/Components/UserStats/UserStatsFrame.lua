local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)

local react = devbox.react

local Component, createBinding, createElement, Ref, Children = devbox.import(react) {
    "Component", "createBinding", "createElement", "Ref", "Children"
}

local Controllers = devbox.controllers
local UserSS = Controllers.GetController("UserSS")

local USF = Component:extend("User Stats Frame")

-- Tweens
local defaultPos = UDim2.new(0.233, 0, 0.215, 0)
local movingPos = UDim2.new(0.233, 0, -0.700, 0)

local tInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

function USF:init()
    self.enabled, self.updateEnabled = createBinding(false)
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

function USF:didMount()
    local frame: Frame = self.frameGet:getValue()

    self.frame = frame
    self.frame.Position = movingPos

    UserSS.event:Connect(function(Type)

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

function USF:willUnmount()
    if self.tweenConnection then
        self.tweenConnection:Disconnect()
        self.tweenConnection = nil
    end
end

function USF:render()
    return createElement("Frame", {
        Name = "User Stats Frame",
        [Ref] = self.frameGet,

        Visible = self.enabled:map(function(value)
            return value
        end),
        Size = UDim2.new(0.478, 0, 0.739, 0),
        Position = UDim2.new(0.261, 0, 0.176, 0),

        BackgroundColor3 = Color3.fromRGB(30, 30, 30),


    }, self.props[Children])
end

return USF