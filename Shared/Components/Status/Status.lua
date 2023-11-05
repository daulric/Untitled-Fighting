local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local react = exon.react
local rednet = exon.rednet

local button = react.Component:extend("Status")

function button:init(props)
	self.text, self.updateText = react.createBinding("")
	self.color, self.updateColor = react.createBinding(Color3.fromRGB(255, 255, 255))
	self.player = props.player
end

function button:didMount()

	local kbd_value = self.player:GetAttribute("KillsBeforeDeath")
	self.updateText(`{kbd_value} Kills Before Death`)

	self.connection = self.player:GetAttributeChangedSignal("KillsBeforeDeath"):Connect(function()
		local currentVal = self.player:GetAttribute("KillsBeforeDeath")
		self.updateText(`{currentVal} Kills Before Death`)
	end)

	self.rednetConnection = rednet.listen("acm_warn", function(message)
		if message ~= nil then
			self.updateColor(Color3.fromRGB(255, 150, 30))
			self.updateText(message)
		end

		task.wait(3)
		self.updateColor(Color3.fromRGB(255, 255, 255))
		self.updateText(`{self.player:GetAttribute("KillsBeforeDeath")} Kills Before Death`)
	end)

end

function button:willUnmount()
	self.updateText("")

	if self.connection then
		self.connection:Disconnect()
		self.connection = nil
	end

	if self.rednetConnection then
		self.rednetConnection:Disconnect()
		self.rednetConnection = nil
	end

end

function button:render()
	return react.createElement("TextLabel", {
		Name = "Status",
		Text = self.text:map(function(value)
			return `<b>{value}</b>`
		end),
		TextScaled = true,
		TextColor3 = self.color:map(function(value)
			return value
		end),
		BackgroundTransparency = 1,
		Size = UDim2.new(.8, 0, .8, 0),
		RichText = true,
		Position = UDim2.new(0.1, 0, 0.1, 0)
	})
end

return button