local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local ColorPicker = {}

local defaultColors = {
    Color3.fromRGB(18, 110, 255),
    Color3.fromRGB(99, 195, 222),
    Color3.fromRGB(255, 176, 63),
    Color3.fromRGB(114, 66, 255),
    Color3.fromRGB(62, 196, 112),
    Color3.fromRGB(255, 90, 123)
}

function ColorPicker.new(parent, props)
    local holder = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "ColorPicker",
        Size = props.Size or UDim2.new(1, 0, 0, 120),
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Light,
        CornerRadius = props.CornerRadius or UDim.new(0, 0, 18),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.72},
        ZIndex = props.ZIndex or 1
    })

    local title = Utils.create("TextLabel", {
        Parent = holder,
        Name = "Title",
        Text = props.Title or "Pilih Warna Tema",
        TextColor3 = Theme.Colors.Text,
        TextSize = 18,
        Font = Enum.Font.GothamSemibold,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -28, 0, 24),
        Position = UDim2.new(0, 14, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local buttonHolder = Utils.create("Frame", {
        Parent = holder,
        Name = "ButtonHolder",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -28, 0, 60),
        Position = UDim2.new(0, 14, 0, 44),
        ZIndex = 1
    })

    local selectedFrame = Utils.CreateRoundedFrame(holder, {
        Name = "SelectedFrame",
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Colors.Primary,
        CornerRadius = UDim.new(0, 0.35),
        ZIndex = 4
    })

    local currentColor = props.DefaultColor or Theme.Colors.Primary

    local function updateSelected(color, target)
        currentColor = color
        if target and typeof(props.OnColorChanged) == "function" then
            props.OnColorChanged(color)
        end
        if selectedFrame and selectedFrame.Parent then
            selectedFrame.BackgroundColor3 = color
        end
    end

    for index, color in ipairs(props.Colors or defaultColors) do
        local colorButton = Utils.CreateRoundedFrame(buttonHolder, {
            Name = "ColorButton" .. index,
            Size = UDim2.new(0, 42, 0, 42),
            Position = UDim2.new(0, (index - 1) * 48, 0, 0),
            BackgroundColor3 = color,
            CornerRadius = UDim.new(0, 0.4),
            ZIndex = 2,
            UIStroke = {Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.4}
        })

        colorButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                updateSelected(color)
            end
        end)

        local indicator = Utils.create("Frame", {
            Parent = colorButton,
            Name = "Indicator",
            Size = UDim2.new(0.4, 0, 0.4, 0),
            Position = UDim2.new(0.3, 0, 0.3, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.2,
            ZIndex = 3
        })

        Utils.create("UICorner", {
            Parent = indicator,
            CornerRadius = UDim.new(0, 10)
        })

        if color == currentColor then
            selectedFrame:Destroy()
            selectedFrame = Utils.CreateRoundedFrame(colorButton, {
                Name = "SelectedFrame",
                Size = UDim2.new(0.9, 0, 0.9, 0),
                Position = UDim2.new(0.05, 0, 0.05, 0),
                BackgroundColor3 = color,
                CornerRadius = UDim.new(0, 16),
                UIStroke = {Color = Color3.fromRGB(255, 255, 255), Thickness = 3, Transparency = 0}
            })
        end
    end

    updateSelected(currentColor)

    return {
        Root = holder,
        SetColor = updateSelected,
        CurrentColor = function()
            return currentColor
        end
    }
end

return ColorPicker
