local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")
local UserInputService = game:GetService("UserInputService")

local Slider = {}

function Slider.new(parent, props)
    local minValue = props.Min or 0
    local maxValue = props.Max or 1
    local step = props.Step or 0.1
    local defaultValue = math.clamp(props.Default or minValue, minValue, maxValue)
    local labelText = props.Label or "Slider"

    local root = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "Slider",
        Size = props.Size or UDim2.new(1, 0, 0, 78),
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Light,
        CornerRadius = props.CornerRadius or UDim.new(0, 0, 18),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.72},
        ZIndex = props.ZIndex or 1
    })

    local title = Utils.create("TextLabel", {
        Parent = root,
        Name = "Title",
        Text = labelText,
        TextColor3 = Theme.Colors.Text,
        TextSize = props.TextSize or 16,
        Font = Enum.Font.GothamSemibold,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 0, 24),
        Position = UDim2.new(0, 0, 0, 10),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local valueLabel = Utils.create("TextLabel", {
        Parent = root,
        Name = "ValueLabel",
        Text = tostring(defaultValue),
        TextColor3 = Theme.Colors.Muted,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 60, 0, 20),
        Position = UDim2.new(1, -64, 0, 10),
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 2
    })

    local track = Utils.CreateRoundedFrame(root, {
        Name = "Track",
        Size = UDim2.new(1, -28, 0, 28),
        Position = UDim2.new(0, 14, 0, 40),
        BackgroundColor3 = props.TrackColor or Color3.fromRGB(228, 233, 241),
        CornerRadius = UDim.new(0, 0.5),
        ZIndex = 2,
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.8}
    })
    track.Active = true

    local fill = Utils.CreateRoundedFrame(track, {
        Name = "Fill",
        Size = UDim2.new((defaultValue - minValue) / math.max(maxValue - minValue, 1), 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = props.FillColor or Theme.Colors.Primary,
        CornerRadius = UDim.new(0, 0.5),
        ZIndex = 3
    })

    local thumb = Utils.CreateRoundedFrame(track, {
        Name = "Thumb",
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(fill.Size.X.Scale, fill.Size.X.Offset, 0, 5),
        BackgroundColor3 = props.ThumbColor or Theme.Colors.Light,
        CornerRadius = UDim.new(0, 0.5),
        ZIndex = 4,
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.7}
    })

    local value = defaultValue
    local dragging = false

    local function updateVisuals(newValue)
        value = math.clamp(math.round(newValue / step) * step, minValue, maxValue)
        local ratio = (value - minValue) / math.max(maxValue - minValue, 1)
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        thumb.Position = UDim2.new(ratio, -9, 0, 5)
        valueLabel.Text = tostring(value)
        if typeof(props.OnChanged) == "function" then
            props.OnChanged(value)
        end
    end

    local function updateFromInput(input)
        if not dragging or input.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        local x = input.Position.X - track.AbsolutePosition.X
        local ratio = math.clamp(x / track.AbsoluteSize.X, 0, 1)
        local newValue = minValue + ratio * (maxValue - minValue)
        updateVisuals(newValue)
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local x = input.Position.X - track.AbsolutePosition.X
            local ratio = math.clamp(x / track.AbsoluteSize.X, 0, 1)
            updateVisuals(minValue + ratio * (maxValue - minValue))
        end
    end)

    track.InputChanged:Connect(function(input)
        updateFromInput(input)
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging then
            updateFromInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return {
        Root = root,
        SetValue = updateVisuals,
        GetValue = function()
            return value
        end
    }
end

return Slider
