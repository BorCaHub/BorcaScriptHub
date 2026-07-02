local UI = GithubRequire("UI/MainUI/MainUI.lua")
local AutoParry = GithubRequire("Main/Script/Blade Ball/Function/Auto Parry.lua")
local Bypass = GithubRequire("Main/Script/Blade Ball/Function/Bypass.lua")

local function buildBladeBallMenu()
    local window = UI.CreateWindow({
        Parent = game.CoreGui,
        Name = "OceanHubBladeBallMenu",
        Title = "Blade Ball",
        Size = UDim2.new(0, 720, 0, 420),
        Position = UDim2.new(0.5, -360, 0.5, -210),
        BackgroundColor3 = Color3.fromRGB(12, 18, 30),
        LogoImage = "rbxassetid://1887484881"
    })

    local header = UI.CreateSection(window.Content, {
        Name = "BladeBallHeader",
        Size = UDim2.new(1, -32, 0, 144),
        Position = UDim2.new(0, 16, 0, 16),
        Title = "Blade Ball",
        Subtitle = "Mode game Blade Ball dengan bypass dan auto parry.",
        BackgroundColor3 = Color3.fromRGB(16, 24, 38),
        TitleColor = Color3.fromRGB(255, 255, 255),
        SubtitleColor = Color3.fromRGB(173, 184, 204)
    })

    header.Root.BackgroundTransparency = 0.02
    header.Root.UIStroke.Color = Color3.fromRGB(82, 96, 128)

    local bypassToggle = UI.CreateToggle(header.Body, {
        Name = "BypassToggle",
        Position = UDim2.new(0, 0, 0, 16),
        Label = "Enable Bypass",
        DefaultOn = false,
        SwitchOnColor = Color3.fromRGB(0, 197, 166),
        SwitchOffColor = Color3.fromRGB(92, 102, 128),
        OnToggle = function(isOn)
            Bypass.SetEnabled(isOn)
        end
    })

    local autoParryToggle = UI.CreateToggle(header.Body, {
        Name = "AutoParryToggle",
        Position = UDim2.new(0, 280, 0, 16),
        Label = "Auto Parry",
        DefaultOn = false,
        SwitchOnColor = Color3.fromRGB(255, 183, 56),
        SwitchOffColor = Color3.fromRGB(92, 102, 128),
        OnToggle = function(isOn)
            AutoParry.SetEnabled(isOn)
        end
    })

    UI.CreateButton(header.Body, {
        Name = "BladeBallStart",
        Position = UDim2.new(0, 0, 0, 84),
        Size = UDim2.new(0, 220, 0, 46),
        Text = "Run Features",
        BackgroundColor3 = Color3.fromRGB(0, 160, 255),
        HoverColor = Color3.fromRGB(0, 130, 215),
        TextSize = 16,
        OnClick = function()
            Bypass.Execute()
            AutoParry.Execute()
            print("Blade Ball features executed")
        end
    })

    local infoSection = UI.CreateSection(window.Content, {
        Name = "BladeBallInfo",
        Size = UDim2.new(1, -32, 0, 170),
        Position = UDim2.new(0, 16, 0, 176),
        Title = "Info",
        Subtitle = "Gunakan tombol di atas untuk menjalankan bypass dan auto parry secara langsung.",
        BackgroundColor3 = Color3.fromRGB(14, 20, 32),
        TitleColor = Color3.fromRGB(255, 255, 255),
        SubtitleColor = Color3.fromRGB(173, 184, 204)
    })

    local bypassDesc = Instance.new("TextLabel")
    bypassDesc.Parent = infoSection.Body
    bypassDesc.Size = UDim2.new(1, 0, 0, 78)
    bypassDesc.Position = UDim2.new(0, 0, 0, 0)
    bypassDesc.BackgroundTransparency = 1
    bypassDesc.Text = "Aktifkan Bypass untuk menjaga skrip berjalan saat kontrol manual tidak aktif. Aktifkan Auto Parry untuk memicu serangan otomatis sesuai setting Anda."
    bypassDesc.TextColor3 = Color3.fromRGB(176, 187, 206)
    bypassDesc.Font = Enum.Font.Gotham
    bypassDesc.TextSize = 14
    bypassDesc.TextWrapped = true
    bypassDesc.TextXAlignment = Enum.TextXAlignment.Left
    bypassDesc.TextYAlignment = Enum.TextYAlignment.Top
    bypassDesc.ZIndex = 3

    return window
end

buildBladeBallMenu()
