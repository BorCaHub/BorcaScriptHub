local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local BrandIcon = {}

function BrandIcon.new(parent, props)
    local icon = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "BrandIcon",
        Size = props.Size or UDim2.new(0, 64, 0, 64),
        Position = props.Position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Primary,
        CornerRadius = props.CornerRadius or UDim.new(0, 0.3),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.4},
        ZIndex = props.ZIndex or 2
    })

    Utils.CreateGradient(icon, {
        Color = Theme.LightGradient(),
        Transparency = NumberSequence.new(0.05),
        Rotation = 130
    })

    local circle = Utils.CreateRoundedFrame(icon, {
        Name = "Circle",
        Size = UDim2.new(0, 38, 0, 38),
        Position = UDim2.new(0.15, 0, 0.15, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        CornerRadius = UDim.new(0, 0.5),
        BackgroundTransparency = 0.15,
        ZIndex = 3
    })

    local wave = Utils.create("Frame", {
        Parent = icon,
        Name = "Wave",
        Size = UDim2.new(0, 44, 0, 16),
        Position = UDim2.new(0.12, 0, 0.55, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 4
    })
    Utils.create("UICorner", {Parent = wave, CornerRadius = UDim.new(0, 8)})

    local innerWave = Utils.create("Frame", {
        Parent = icon,
        Name = "InnerWave",
        Size = UDim2.new(0, 28, 0, 12),
        Position = UDim2.new(0.22, 0, 0.64, 0),
        BackgroundColor3 = Theme.Colors.Primary,
        BorderSizePixel = 0,
        ZIndex = 5
    })
    Utils.create("UICorner", {Parent = innerWave, CornerRadius = UDim.new(0, 8)})

    return icon
end

return BrandIcon
