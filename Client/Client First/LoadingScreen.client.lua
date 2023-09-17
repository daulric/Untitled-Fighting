game.ReplicatedFirst:RemoveDefaultLoadingScreen()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local devbox = require(ReplicatedStorage:WaitForChild("Packages").devbox)
local controllers = devbox.controllers

local Icon = require(ReplicatedStorage:WaitForChild("SystemPackages").Icon)

local Components = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Components")
local loadingFrags = require(Components:WaitForChild("LoadingScreen").LoadingFrags)

local react = devbox.react

local createElement, mount, unmount = devbox.import(react) {
    "createElement", "mount", "unmount"
}

local loadingElement = createElement("ScreenGui", {
    Name = "Loading Screen",
    IgnoreGuiInset = true,
    DisplayOrder = 1,
    ResetOnSpawn = false,
}, {
    LoadingFrame = createElement("Frame", {
        Name = "Loading Frame",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
    }, {
        LoadingFragments = createElement(loadingFrags)
    })
})

local handle
local connect

connect = player:GetAttributeChangedSignal("AFK"):Connect(function()
    local attribute = player:GetAttribute("AFK")

    if attribute == false then
       task.wait(2)
       unmount(handle)
       connect:Disconnect()
    end
end)

handle = mount(loadingElement, player.PlayerGui)

-- Handling Icons
repeat task.wait(1) until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All) == true

local UserStatsSelection = controllers.GetController("UserSS")

local icon = Icon.new()

icon:setImage("http://www.roblox.com/asset/?id=6022668898")
icon:setCaption("Stats")

icon:bindEvent("selected", function(element)
	UserStatsSelection:SendSignal("select")
end)

icon:bindEvent("deselected", function(element)
	UserStatsSelection:SendSignal("deselect")
end)