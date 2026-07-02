local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local Notification = {}

function Notification.new(parent, props)
    local root = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "NotificationToast",
        Size = props.Size or UDim2.new(0, 320, 0, 96),
        Position = props.Position or UDim2.new(1, -348, 1, -120),
        AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
        BackgroundColor3 = props.BackgroundColor3 or Color3.fromRGB(25, 27, 35),
        CornerRadius = props.CornerRadius or UDim.new(0, 0.18),
        UIStroke = {Color = props.BorderColor or Theme.Colors.Primary, Thickness = 1, Transparency = 0.65},
        ZIndex = props.ZIndex or 10
    })

    local title = Utils.create("TextLabel", {
        Parent = root,
        Name = "Title",
        Text = props.Title or "Notification",
        TextColor3 = props.TitleColor or Color3.fromRGB(255, 255, 255),
        Font = props.TitleFont or Enum.Font.GothamBold,
        TextSize = props.TitleSize or 18,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 0, 26),
        Position = UDim2.new(0, 0, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 11
    })

    local message = Utils.create("TextLabel", {
        Parent = root,
        Name = "Message",
        Text = props.Message or "Informasi penting akan ditampilkan di sini.",
        TextColor3 = props.MessageColor or Color3.fromRGB(201, 209, 217),
        Font = props.MessageFont or Enum.Font.Gotham,
        TextSize = props.MessageSize or 14,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 0, 48),
        Position = UDim2.new(0, 0, 0, 34),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 11
    })

    local duration = tonumber(props.Duration) or 4
    task.delay(duration, function()
        if root and root.Parent then
            root:Destroy()
        end
    end)

    return {
        Root = root,
        Title = title,
        Message = message,
        Destroy = function()
            if root and root.Parent then
                root:Destroy()
            end
        end
    }
end

return Notification
