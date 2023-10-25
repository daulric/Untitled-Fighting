local ReplicatedStorage = game:GetService("ReplicatedStorage")
local devbox = require(ReplicatedStorage.Packages:WaitForChild("devbox"))

local react = devbox.react

local InputComponent = react.Component:extend("Input Setting Component")



return InputComponent