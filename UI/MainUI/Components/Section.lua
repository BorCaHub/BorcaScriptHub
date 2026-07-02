local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local Section = {}

function Section.new(parent, props)
    local section = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "Section",
        Size = props.Size or UDim2.new(1, 0, 0, 180),
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Light,
        CornerRadius = props.CornerRadius or UDim.new(0, 0, 18),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.72},
        ZIndex = props.ZIndex or 1
    })

    local header = Utils.create("TextLabel", {
        Parent = section,
        Name = "Header",
        Text = props.Title or "Section Title",
        TextColor3 = props.TitleColor or Theme.Colors.Text,
        TextSize = props.TitleSize or 20,
        Font = props.TitleFont or Enum.Font.GothamSemibold,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -28, 0, 26),
        Position = UDim2.new(0, 14, 0, 14),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local subtitle = Utils.create("TextLabel", {
        Parent = section,
        Name = "Subtitle",
        Text = props.Subtitle or "Deskripsi singkat fitur.",
        TextColor3 = props.SubtitleColor or Theme.Colors.Muted,
        TextSize = props.SubtitleSize or 14,
        Font = props.SubtitleFont or Enum.Font.Gotham,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -28, 0, 44),
        Position = UDim2.new(0, 14, 0, 44),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 2
    })

    local body = Utils.create("Frame", {
        Parent = section,
        Name = "Body",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -28, 1, -72),
        Position = UDim2.new(0, 14, 0, 68),
        ZIndex = 1
    })

    return {
        Root = section,
        Header = header,
        Subtitle = subtitle,
        Body = body
    }
end

return Section
