local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CharacterFiles = ReplicatedStorage.Shared:WaitForChild("CharacterFiles")

local oneframe = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("exon")).oneframe

local char = script.Parent.Parent
local player = game.Players.LocalPlayer

oneframe.Start(CharacterFiles, char, player)