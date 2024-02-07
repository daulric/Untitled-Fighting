local ContentProvider = game:GetService("ContentProvider")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GroupService = game:GetService("GroupService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local exon = require(ReplicatedStorage:WaitForChild("Packages").exon)
local rednet = exon.rednet
local util = exon.util

local Component, createElement, createFragment, Ref, createRef, createBinding = exon.import(exon.react) {
    "Component", "createElement", "createFragment", "Ref", "createRef", "createBinding"
}

local Assets = {
    unpack(game:GetDescendants()),
}

local TransparencyType = {
    TextLabel = "TextTransparency",
    ImageLabel = "ImageTransparency",
    Frame = "BackgroundTransparency",
}

local Loading = Component:extend("Loading Screen Image")

function Loading:updateCoreUI(bool: boolean)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, bool)
end

function Loading:init()
    self.imageLabel = createRef()
    self.loadingtextlabel = createRef()
    self.gameName = createRef()
    
    -- Bindings
    self.image, self.updateImage = createBinding("")
    self.gameNameText, self.updateGameName = createBinding("")
    self.loadingText, self.updateLoadingText = createBinding("")
    self.transparency, self.updateTransparency = createBinding(0)

    self.loadSize, self.updateloadSize = createBinding(0)

    self:setState({
        font = Enum.Font.Cartoon,
    })

end

function Loading:didMount()
    local GameData = MarketplaceService:GetProductInfo(game.PlaceId)
    local GroupData = GroupService:GetGroupInfoAsync(12852480)

    self:updateCoreUI(false)

    self.updateImage(GroupData.EmblemUrl)
    self.updateGameName(GameData.Name)

    task.spawn(function()

        util.createCounter(1, #Assets, 1, function(index)
            local asset = Assets[index]
            ContentProvider:PreloadAsync({asset})
            local percent = math.floor((index / #Assets) * 100)
            self.updateLoadingText(`{index} / {#Assets} : {percent}%`)
            self.updateloadSize(index / #Assets)
            task.wait(0)
        end)

        self.updateTransparency(1)
        self.updateLoadingText("Completed")

        local items = {
            self.imageLabel.value,
            self.loadingtextlabel.value,
            self.gameName.value,
            self.imageLabel.value.Parent,
        }

        task.wait(1)

        util.iterate(items, function(_, v)
            task.spawn(function()
                local tinfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

                local infotype = TransparencyType[v.ClassName]
            
                local tween = TweenService:Create(v, tinfo, {
                    [infotype] = 1,
                })

                tween:Play()
            end)
        end)

        task.wait()
        rednet:FireServer("afk", false)

    end)

end

function Loading:willUnmount()
    self:updateCoreUI(true)
    self.updateLoadingText("")
    self.updateImage("")
    self.updateGameName("")
end

function Loading:render()
    return createFragment({

        Image = createElement("ImageLabel", {
            [Ref] = self.imageLabel,
            Name = "Loading Screen Image",
            Image = self.image:map(function(value)
                return value
            end),
            Position = UDim2.new(0.5, 0, 0.3, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromScale(0.5, 0.5),
            BackgroundTransparency = 1,
        }, {
            UIAspect = createElement("UIAspectRatioConstraint"),
            UICorner = createElement("UICorner", {
                CornerRadius = UDim.new(1, 0),
            })
        }),

        TextLabel = createElement("TextLabel", {
            [Ref] = self.gameName,
            Name = "Loading Screen Game Name",
            Text = self.gameNameText:map(function(value)
                return value
            end),
            Position = UDim2.new(0.5, 0, 0.65, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(0.386, 0,0.188, 0),
            TextScaled = true,
            Font = self.state.font,
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }),

        LoadingLabel = createElement("TextLabel", {
            [Ref] = self.loadingtextlabel,
            Name = "Loading",
            Text = self.loadingText:map(function(value)
                return value
            end),
            Position = UDim2.new(0.5, 0, 0.8, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(0.611, 0,0.083, 0),
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = self.state.font,
            BackgroundTransparency = 1,
        }, {
            UIAspect = createElement("UIAspectRatioConstraint", {
                AspectRatio = 8,
            })
        }),

        LoadingBar = createElement("Frame", {
            Name = "Loading Bar",
            Size = UDim2.new(0.5, 0.1, 0.049, 0),
            Position = UDim2.new(0.5, 0, 0.9, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(84, 78, 78),
            BackgroundTransparency = self.transparency:map(function(value)
                return value
            end)
        }, {
            UICorner = createElement("UICorner", {
                Name = "UI Corner",
                CornerRadius = UDim.new(0, 8),
            }),

            LoadFrame = createElement("Frame", {
                Name = "LoadFrame",
                Size = self.loadSize:map(function(value)
                    return UDim2.new(value, 0, 1, 0)
                end),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(207, 204, 204),
                BackgroundTransparency = self.transparency:map(function(value)
                    return value
                end)
            }, {
                UICorner = createElement("UICorner", {
                    Name = "UI Corner",
                    CornerRadius = UDim.new(0, 8),
                })
            })
        })

    })
end

return Loading