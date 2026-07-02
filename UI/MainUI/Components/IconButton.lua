local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local IconButton = {}

function IconButton.new(parent, props)
    local button = Utils.create("TextButton", {
        Parent = parent,
        Name = props.Name or "IconButton",
        Size = props.Size or UDim2.new(0, 52, 0, 52),
        Position = props.Position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Light,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        ZIndex = props.ZIndex or 2
    })

    Utils.create("UICorner", {
        Parent = button,
        CornerRadius = props.CornerRadius or UDim.new(0, 0.35)
    })

    if props.IconImage then
        Utils.create("ImageLabel", {
            Parent = button,
            Name = "IconImage",
            Size = UDim2.new(0, 0, 0, 30),
            Position = UDim2.new(0.5, -15, 0.5, -15),
            BackgroundTransparency = 1,
            Image = props.IconImage,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = 3
        })
    elseif props.IconText then
        Utils.create("TextLabel", {
            Parent = button,
            Name = "IconText",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = props.IconText,
            TextColor3 = props.TextColor3 or Theme.Colors.Text,
            Font = props.Font or Enum.Font.GothamBold,
            TextSize = props.TextSize or 20,
            ZIndex = 3
        })
    end

    if typeof(props.OnClick) == "function" then
        button.MouseButton1Click:Connect(props.OnClick)
    end

    return button
end

return IconButton
