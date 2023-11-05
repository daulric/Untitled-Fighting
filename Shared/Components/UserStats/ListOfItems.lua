local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)
local react = exon.react

local Temp = script.Parent:WaitForChild("Temp")
local TempFrame = require(Temp:WaitForChild("StatsTempFrame"))
local TempTextLabel = require(Temp:WaitForChild("TextLabel"))
local TempImageLabel = require(Temp:WaitForChild("ImageLabel"))

local player = Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats", 10)

function CreateAList(props)
    return react.createElement(TempFrame, {}, {

        TextLabel = react.createElement(TempTextLabel, {
            Text = props.text,
        }),

        Image = react.createElement(TempImageLabel, {
            image = props.image
        }),
    
        Corner = react.createElement("UICorner", {
            Name = "Corner",
            CornerRadius = UDim.new(0, 6),
        })
    })
end

local bits, updateBits = react.createBinding(0)
local level, updateLevel = react.createBinding({
    xp = 0,
    requiredXp = 0,
    level = 0,
})
local kd, updateKD = react.createBinding({
    kills = 0,
    deaths = 0,
    kd = 0,
})

function updateData()
    updatePlayerLevel()
    updateKillsDeath()
    updateBits(leaderstats:GetAttribute("Bits"))
end

function updatePlayerLevel()
    updateLevel({
        xp = leaderstats:GetAttribute("Xp"),
        requiredXp = leaderstats:GetAttribute("RequiredXp"),
        level = leaderstats:GetAttribute("Level"),
    })
end

function updateKillsDeath()
    local kills = leaderstats:GetAttribute("Kills") or 0
    local deaths = leaderstats:GetAttribute("Deaths") or 0

    updateKD({
        kills = kills,
        deaths = deaths,
        kd = math.floor((kills / deaths) * 100)
    })
end

function updatePlayerLevelSignal()
    leaderstats:GetAttributeChangedSignal("Bits"):Connect(function()
        updateBits(leaderstats:GetAttribute("Bits"))
    end)

    leaderstats:GetAttributeChangedSignal("Xp"):Connect(function()
        updatePlayerLevel()
    end)
    leaderstats:GetAttributeChangedSignal("Level"):Connect(function()
        updatePlayerLevel()
    end)

    leaderstats:GetAttributeChangedSignal("Kills"):Connect(function()
        updateKillsDeath()
    end)

    leaderstats:GetAttributeChangedSignal("Deaths"):Connect(function()
        updateKillsDeath()
    end)

end

-- Updating Items
updateData()
updatePlayerLevelSignal()

local bitFrame = react.createElement(CreateAList, {
    text = bits:map(function(value)
        return `<b>Bits : {value}</b>`
    end),
    image = `http://www.roblox.com/asset/?id=6034973115`
})

local levelFrame = react.createElement(CreateAList, {
    text = level:map(function(value)
        return `<b>Level: {value.level} || {value.xp} / {value.requiredXp}</b>`
    end),
    image = "http://www.roblox.com/asset/?id=6031225815"
})

local kdFrame = react.createElement(CreateAList, {
    text = kd:map(function(value)
        return `<b> K: {value.kills} | D: {value.deaths} || K/D: {value.kd}% </b>`
    end),
    image = "http://www.roblox.com/asset/?id=6026568216",
})

return {
    Bits = bitFrame,
    LevelFrame = levelFrame,
    KDFrame = kdFrame
}