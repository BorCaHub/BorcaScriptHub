local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")
local Toggle = GithubRequire("UI/MainUI/Components/Toggle.lua")
local RunService = game:GetService("RunService")

local AutoButton = {}

function AutoButton.new(parent, props)
    props = props or {}
    local interval = props.Interval or 1
    local isAuto = props.DefaultOn or false
    local statusText = props.StatusText or "Auto off"

    local root = Utils.CreateRoundedFrame(parent, {
        Name = props.Name or "AutoButtonPanel",
        Size = props.Size or UDim2.new(1, 0, 0, 170),
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        BackgroundColor3 = props.BackgroundColor3 or Theme.Colors.Light,
        CornerRadius = props.CornerRadius or UDim.new(0, 0.25),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.72},
        ZIndex = props.ZIndex or 1
    })

    local title = Utils.create("TextLabel", {
        Parent = root,
        Name = "Title",
        Text = props.Title or "Auto Buy Controller",
        TextColor3 = Theme.Colors.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 18,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 0, 24),
        Position = UDim2.new(0, 12, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local status = Utils.create("TextLabel", {
        Parent = root,
        Name = "Status",
        Text = statusText,
        TextColor3 = Theme.Colors.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 0, 20),
        Position = UDim2.new(0, 12, 0, 40),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local mainButton = Utils.create("TextButton", {
        Parent = root,
        Name = props.ButtonName or "AutoActionButton",
        Size = UDim2.new(0, 240, 0, 54),
        Position = UDim2.new(0, 12, 0, 72),
        BackgroundColor3 = props.ButtonColor or Theme.Colors.Primary,
        BorderSizePixel = 0,
        Text = props.ButtonText or "Remote Buy",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamSemibold,
        TextSize = 18,
        AutoButtonColor = false,
        ZIndex = 3
    })
    Utils.create("UICorner", {Parent = mainButton, CornerRadius = UDim.new(0, 18)})

    local onToggle = function(value)
        isAuto = value
        status.Text = isAuto and "Auto mode aktif" or "Auto mode nonaktif"
        if typeof(props.OnToggle) == "function" then
            props.OnToggle(isAuto)
        end
    end

    local toggleControl = Toggle.new(root, {
        Name = "AutoToggle",
        Position = UDim2.new(0, 272, 0, 80),
        Label = "Auto On/Off",
        DefaultOn = isAuto,
        OnToggle = onToggle
    })

    local intervalLabel = Utils.create("TextLabel", {
        Parent = root,
        Name = "IntervalLabel",
        Text = string.format("Delay: %.1fs", interval),
        TextColor3 = Theme.Colors.Text,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 240, 0, 18),
        Position = UDim2.new(0, 12, 0, 136),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })

    local lastFire = 0
    local function fireAction()
        if typeof(props.OnClick) == "function" then
            props.OnClick()
        end
        lastFire = tick()
    end

    mainButton.MouseButton1Click:Connect(fireAction)

    RunService.Heartbeat:Connect(function(dt)
        if not isAuto then
            return
        end

        if tick() - lastFire >= interval then
            fireAction()
            lastFire = tick()
        end
    end)

    return {
        Root = root,
        SetAuto = function(value)
            toggleControl.SetState(value)
            onToggle(value)
        end,
        SetInterval = function(value)
            if type(value) ~= "number" or value <= 0 then
                return
            end
            interval = value
            intervalLabel.Text = string.format("Delay: %.1fs", interval)
        end,
        IsAuto = function()
            return isAuto
        end
    }
end

return AutoButton
