local UI = GithubRequire("UI/MainUI/MainUI.lua")
local AutoButton = GithubRequire("Main/Script/Sell Lemons/Function/Auto Button.lua")

local function buildSellLemonsMenu()
    local window = UI.CreateWindow({
        Parent = game.CoreGui,
        Name = "OceanHubSellLemonsMenu",
        Title = "Sell Lemons",
        Size = UDim2.new(0, 720, 0, 420),
        Position = UDim2.new(0.5, -360, 0.5, -210),
        BackgroundColor3 = Color3.fromRGB(18, 24, 42),
        LogoImage = "rbxassetid://1887484881"
    })

    local header = UI.CreateSection(window.Content, {
        Name = "SellLemonsHeader",
        Size = UDim2.new(1, -32, 0, 140),
        Position = UDim2.new(0, 16, 0, 16),
        Title = "Remote Buy",
        Subtitle = "Tekan tombol untuk membeli secara remote atau aktifkan auto buy.",
        BackgroundColor3 = Color3.fromRGB(16, 22, 35),
        TitleColor = Color3.fromRGB(255, 255, 255),
        SubtitleColor = Color3.fromRGB(175, 184, 206)
    })

    header.Root.BackgroundTransparency = 0.02
    header.Root.UIStroke.Color = Color3.fromRGB(75, 91, 129)

    UI.CreateButton(header.Body, {
        Name = "BuyButton",
        Position = UDim2.new(0, 0, 0, 12),
        Size = UDim2.new(0, 240, 0, 48),
        Text = "Buy Now",
        BackgroundColor3 = Color3.fromRGB(0, 185, 147),
        HoverColor = Color3.fromRGB(0, 160, 130),
        TextSize = 18,
        OnClick = function()
            AutoButton.Execute()
            print("Sell Lemons buy pressed")
        end
    })

    local autoToggle = UI.CreateToggle(header.Body, {
        Name = "AutoBuyToggle",
        Position = UDim2.new(0, 260, 0, 16),
        Label = "Auto Buy",
        DefaultOn = false,
        SwitchOnColor = Color3.fromRGB(255, 183, 56),
        SwitchOffColor = Color3.fromRGB(92, 102, 128),
        OnToggle = function(isOn)
            AutoButton.SetEnabled(isOn)
        end
    })

    local configSection = UI.CreateSection(window.Content, {
        Name = "ConfigSection",
        Size = UDim2.new(1, -32, 0, 170),
        Position = UDim2.new(0, 16, 0, 172),
        Title = "Auto Buy Settings",
        Subtitle = "Kelola otomatisasi dengan mudah tanpa mengubah file feature.",
        BackgroundColor3 = Color3.fromRGB(14, 18, 28),
        TitleColor = Color3.fromRGB(255, 255, 255),
        SubtitleColor = Color3.fromRGB(167, 176, 195)
    })

    local configLabel = Instance.new("TextLabel")
    configLabel.Parent = configSection.Body
    configLabel.Size = UDim2.new(1, 0, 0, 90)
    configLabel.Position = UDim2.new(0, 0, 0, 0)
    configLabel.BackgroundTransparency = 1
    configLabel.Text = "Aktifkan Auto Buy untuk menjalankan pembelian otomatis setiap interval. Tekan Buy Now jika ingin eksekusi manual segera."
    configLabel.TextColor3 = Color3.fromRGB(185, 192, 205)
    configLabel.Font = Enum.Font.Gotham
    configLabel.TextSize = 14
    configLabel.TextWrapped = true
    configLabel.TextXAlignment = Enum.TextXAlignment.Left
    configLabel.TextYAlignment = Enum.TextYAlignment.Top
    configLabel.ZIndex = 3

    return window
end

buildSellLemonsMenu()
