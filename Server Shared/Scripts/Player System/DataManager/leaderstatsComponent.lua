local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages:WaitForChild("exon"))

local react = exon.react

local leaderstatsComp = react.Component:extend("leaderstats component")

function leaderstatsComp:init()
    self.killsRef = react.createRef()
    self.kills, self.updateKills = react.createBinding(0)
end

function leaderstatsComp:didMount()
    self.leaderstats = self.killsRef:getValue().Parent

    self.killsDisconnect = self.leaderstats:GetAttributeChangedSignal("Kills"):Connect(function()
        self.updateKills(self.leaderstats:GetAttribute("Kills"))
    end)

end

function leaderstatsComp:willUnmount()
    if self.killsDisconnect then
        self.killsDisconnect:Disconnect()
        self.killsDisconnect = nil
    end
end

function leaderstatsComp:render()
    return react.createFragment({

        Kills = react.createElement("NumberValue", {
            [react.Ref] = self.killsRef,
            Name = "Kills",
            Value = self.kills:map(function(value)
                return value
            end),
        }),

    })
end

return leaderstatsComp