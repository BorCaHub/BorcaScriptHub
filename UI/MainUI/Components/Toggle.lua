local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local Toggle = {}

function Toggle.new(parent, props)
    local root = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "Toggle",
        Size = props.Size or UDim2.new(0, 140, 0, 44),
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Light,
        CornerRadius = props.CornerRadius or UDim.new(0, 0.25),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.7},
        ZIndex = props.ZIndex or 1
    })

    local label = Utils.create("TextLabel", {
        Parent = root,
        Name = "ToggleLabel",
        Text = props.Label or "Toggle",
        TextColor3 = Theme.Colors.Text,
        Font = Enum.Font.Gotham,
        TextSize = 15,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.58, 0, 1, 0),
        Position = UDim2.new(0.04, 0, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = 2
    })

    local switch = Utils.CreateRoundedFrame(root, {
        Name = "Switch",
        Size = UDim2.new(0, 60, 0, 28),
        Position = UDim2.new(0.63, 0, 0.15, 0),
        BackgroundColor3 = props.SwitchOffColor or Color3.fromRGB(223, 227, 235),
        CornerRadius = UDim.new(0, 16),
        ZIndex = 2
    })

    local knob = Utils.CreateRoundedFrame(switch, {
        Name = "Knob",
        Size = UDim2.new(0, 26, 0, 26),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = props.KnobColor or Theme.Colors.Light,
        CornerRadius = UDim.new(0, 0.5),
        ZIndex = 3
    })

    local isOn = props.DefaultOn or false

    local function refreshState()
        if isOn then
            switch.BackgroundColor3 = props.SwitchOnColor or Theme.Colors.Primary
            knob.Position = UDim2.new(0.55, 0, 0.05, 0)
        else
            switch.BackgroundColor3 = props.SwitchOffColor or Color3.fromRGB(223, 227, 235)
            knob.Position = UDim2.new(0, 1, 0, 1)
        end
    end

    local function toggle()
        isOn = not isOn
        refreshState()
        if typeof(props.OnToggle) == "function" then
            props.OnToggle(isOn)
        end
    end

    root.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggle()
        end
    end)

    refreshState()

    return {
        Root = root,
        SetState = function(value)
            isOn = value and true or false
            refreshState()
        end,
        IsOn = function()
            return isOn
        end
    }
end

return Toggle
