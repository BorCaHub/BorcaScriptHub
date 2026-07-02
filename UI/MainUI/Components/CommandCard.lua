local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")
local Button = GithubRequire("UI/MainUI/Components/Button.lua")

local CommandCard = {}

function CommandCard.new(parent, props)
    local root = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "CommandCard",
        Size = props.Size or UDim2.new(1, 0, 0, 128),
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Light,
        CornerRadius = props.CornerRadius or UDim.new(0, 0, 18),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.65},
        ZIndex = props.ZIndex or 1
    })

    local iconFrame = Utils.CreateRoundedFrame(root, {
        Name = "CommandIcon",
        Size = UDim2.new(0, 56, 0, 56),
        Position = UDim2.new(0, 16, 0, 36),
        BackgroundColor3 = props.IconBackgroundColor or Theme.Colors.Primary,
        CornerRadius = UDim.new(0, 0.4),
        ZIndex = 2,
        UIStroke = {Color = Color3.fromRGB(255, 255, 255), Thickness = 1, Transparency = 0.7}
    })

    if props.IconImage then
        Utils.create("ImageLabel", {
            Parent = iconFrame,
            Name = "IconImage",
            Size = UDim2.new(0, 0, 0, 32),
            Position = UDim2.new(0.5, -16, 0.5, -16),
            BackgroundTransparency = 1,
            Image = props.IconImage,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = 3
        })
    else
        Utils.create("TextLabel", {
            Parent = iconFrame,
            Name = "IconText",
            Size = UDim2.new(1, 1, 1, 1),
            BackgroundTransparency = 1,
            Text = props.IconText or "C",
            TextColor3 = props.IconTextColor or Color3.fromRGB(255, 255, 255),
            Font = props.IconFont or Enum.Font.GothamBold,
            TextSize = props.IconTextSize or 24,
            ZIndex = 3
        })
    end

    local title = Utils.create("TextLabel", {
        Parent = root,
        Name = "CardTitle",
        Text = props.Title or "Command",
        TextColor3 = Theme.Colors.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 18,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -112, 0, 26),
        Position = UDim2.new(0, 90, 0, 24),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local subtitle = Utils.create("TextLabel", {
        Parent = root,
        Name = "CardSubtitle",
        Text = props.Subtitle or "Detail perintah singkat.",
        TextColor3 = Theme.Colors.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -112, 0, 46),
        Position = UDim2.new(0, 90, 0, 50),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 2
    })

    local actionButton = Button.new(root, {
        Name = props.ButtonName or "CardAction",
        Text = props.ButtonText or "Run",
        Size = UDim2.new(0, 120, 0, 40),
        Position = UDim2.new(1, -136, 0, 44),
        BackgroundColor3 = props.ButtonColor or Theme.Colors.Primary,
        HoverColor = props.ButtonHoverColor or Color3.fromRGB(16, 96, 214),
        TextSize = 14,
        CornerRadius = UDim.new(0, 0.35),
        OnClick = props.OnClick
    })

    return {
        Root = root,
        ActionButton = actionButton
    }
end

return CommandCard
