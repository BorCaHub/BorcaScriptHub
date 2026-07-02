local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")

local Window = {}

function Window.new(options)
    local parent = options.Parent or game.CoreGui
    local window = Utils.CreateRoundedFrame(parent, {
        Name = options.Name or "OceanHubWindow",
        Size = options.Size or UDim2.new(0, 700, 0, 420),
        Position = options.Position or UDim2.new(0.5, -350, 0.5, -210),
        AnchorPoint = options.AnchorPoint or Vector2.new(0.5, 0.5),
        BackgroundColor3 = options.BackgroundColor3 or Theme.Colors.Background,
        CornerRadius = options.CornerRadius or UDim.new(0, 24),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 2, Transparency = 0.6},
        ZIndex = options.ZIndex or 1
    })

    local titleBar = Utils.CreateRoundedFrame(window, {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 68),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(245, 249, 255),
        CornerRadius = UDim.new(0, 24),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.7},
        ZIndex = 2
    })

    local logo = Utils.create("ImageLabel", {
        Parent = titleBar,
        Name = "Logo",
        Size = UDim2.new(0, 0, 0, 40),
        Position = UDim2.new(0, 18, 0.5, -20),
        BackgroundTransparency = 1,
        Image = options.LogoImage or "rbxassetid://0",
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 3
    })

    local title = Utils.create("TextLabel", {
        Parent = titleBar,
        Name = "Title",
        Text = options.Title or "OceanHub Menu",
        TextColor3 = Theme.Colors.Text,
        TextSize = 26,
        Font = Enum.Font.GothamSemibold,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 260, 0, 40),
        Position = UDim2.new(0, 82, 0.5, -20),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3
    })

    local content = Utils.create("Frame", {
        Parent = window,
        Name = "Content",
        Size = UDim2.new(1, -24, 1, -90),
        Position = UDim2.new(0, 12, 0, 78),
        BackgroundTransparency = 1,
        ZIndex = 1
    })

    return {
        Root = window,
        Content = content,
        Title = title,
        Logo = logo,
        Close = function()
            window:Destroy()
        end
    }
end

return Window
