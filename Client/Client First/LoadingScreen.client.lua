game.ReplicatedFirst:RemoveDefaultLoadingScreen()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local Components = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Components")
local loadingFrags = require(Components:WaitForChild("LoadingScreen").LoadingFrags)

local react = exon.react

local createElement, mount, unmount = exon.import(react) {
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