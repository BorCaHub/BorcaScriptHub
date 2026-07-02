local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local Button = {}

function Button.new(parent, props)
    local button = Utils.create("TextButton", {
        Parent = parent,
        Name = props.Name or "Button",
        Size = props.Size or UDim2.new(0, 180, 0, 44),
        Position = props.Position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Primary,
        BorderSizePixel = 0,
        Text = props.Text or "Button",
        TextColor3 = props.TextColor3 or Color3.fromRGB(255, 255, 255),
        Font = props.Font or Enum.Font.GothamSemibold,
        TextSize = props.TextSize or 16,
        AutoButtonColor = false,
        ZIndex = props.ZIndex or 2
    })

    Utils.create("UICorner", {
        Parent = button,
        CornerRadius = props.CornerRadius or UDim.new(0, 16)
    })

    Utils.create("UIStroke", {
        Parent = button,
        Color = props.StrokeColor or Theme.Colors.Secondary,
        Thickness = props.StrokeThickness or 1,
        Transparency = 0.6
    })

    local normalColor = button.BackgroundColor3
    local hoverColor = props.HoverColor or Color3.fromRGB(10, 94, 238)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hoverColor
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = normalColor
    end)

    if typeof(props.OnClick) == "function" then
        button.MouseButton1Click:Connect(props.OnClick)
    end

    return button
end

return Button
