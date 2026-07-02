local UI = GithubRequire("UI/MainUI/MainUI.lua")
local DeviceConfig = GithubRequire("Main/Loader/DeviceConfig/ConfigManager.lua")
local SupabaseClient = GithubRequire("Main/Loader/SupabaseClient.lua")

local LoaderMenu = {}

function LoaderMenu.build(parent, deviceConfig)
    deviceConfig = deviceConfig or DeviceConfig.Get("Default")

    local window = UI.CreateWindow({
        Parent = parent,
        Name = "OceanHubLoaderMenu",
        Title = "OceanHub",
        Size = deviceConfig.WindowSize or UDim2.new(0, 780, 0, 480),
        Position = deviceConfig.WindowPosition or UDim2.new(0.5, -390, 0.5, -240),
        BackgroundColor3 = Color3.fromRGB(63, 191, 255),
        LogoImage = "rbxassetid://1887484881"
    })

    UI.CreateNotification(game.CoreGui, {
        Title = "OceanHub",
        Message = "Loaded with " .. deviceConfig.Name .. " configuration.",
        Duration = 5
    })

    local topStrip = UI.CreateSection(window.Content, {
        Name = "TopStrip",
        Size = UDim2.new(1, 0, 0, 96),
        Position = UDim2.new(0, 0, 0, -6),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Title = "",
        Subtitle = "",
        CornerRadius = UDim.new(0, 0, 24)
    })
    topStrip.Root.BackgroundTransparency = 0.2
    topStrip.Root.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    UI.CreateBrandIcon(topStrip.Root, {
        Position = UDim2.new(0, 18, 0.5, -32),
        Size = UDim2.new(0, 68, 0, 68),
        BackgroundColor3 = Color3.fromRGB(19, 95, 255)
    })

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = topStrip.Root
    titleLabel.Size = UDim2.new(0, 0, 0, 36)
    titleLabel.Position = UDim2.new(0, 104, 0.5, -24)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "OceanHub"
    titleLabel.TextColor3 = Color3.fromRGB(17, 24, 54)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 28
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 5

    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Parent = topStrip.Root
    subtitleLabel.Size = UDim2.new(0, 360, 0, 20)
    subtitleLabel.Position = UDim2.new(0, 104, 0.5, 10)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = "Menu custom OceanHub dengan pilihan Free dan Premium."
    subtitleLabel.TextColor3 = Color3.fromRGB(84, 98, 123)
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextSize = 14
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.ZIndex = 5

    local tabView = UI.CreateTabView(window.Content)

    tabView:AddTab("Free", function(page)
        local sectionA = UI.CreateSection(page, {
            Name = "FreeInfo",
            Size = UDim2.new(1, -32, 0, 190),
            Position = UDim2.new(0, 16, 0, 16),
            Title = "Free Mode",
            Subtitle = "Akses fitur dasar cepat dengan tampilan ringan dan kontrol sederhana."
        })

        UI.CreateIconButton(sectionA.Body, {
            Name = "FreeIcon",
            Position = UDim2.new(0, 0, 0, 0),
            IconText = "F",
            BackgroundColor3 = Color3.fromRGB(110, 201, 255)
        })

        local description = Instance.new("TextLabel")
        description.Parent = sectionA.Body
        description.Size = UDim2.new(1, 0, 0, 80)
        description.Position = UDim2.new(0, 80, 0, 0)
        description.BackgroundTransparency = 1
        description.Text = "Cocok untuk pengujian dan penggunaan ringan. Gunakan tab ini untuk melihat paket Free dengan tombol fungsi cepat."
        description.TextColor3 = Color3.fromRGB(38, 52, 86)
        description.TextSize = 16
        description.TextWrapped = true
        description.Font = Enum.Font.Gotham
        description.TextXAlignment = Enum.TextXAlignment.Left
        description.TextYAlignment = Enum.TextYAlignment.Top

        UI.CreateButton(sectionA.Body, {
            Name = "FreeAction",
            Position = UDim2.new(0, 0, 0, 110),
            Text = "Pilih Free",
            Size = UDim2.new(0, 180, 0, 44),
            BackgroundColor3 = Color3.fromRGB(32, 161, 255),
            HoverColor = Color3.fromRGB(22, 131, 235),
            OnClick = function()
                print("Free mode selected")
            end
        })

        UI.CreateColorPicker(sectionA.Body, {
            Position = UDim2.new(0, 240, 0, 110),
            Size = UDim2.new(1, -240, 0, 120),
            Title = "Tema UI Free",
            DefaultColor = Color3.fromRGB(18, 110, 255),
            OnColorChanged = function(color)
                sectionA.Root.UIStroke.Color = color
            end
        })
    end)

    tabView:AddTab("Premium", function(page)
        local sectionB = UI.CreateSection(page, {
            Name = "PremiumInfo",
            Size = UDim2.new(1, -32, 0, 230),
            Position = UDim2.new(0, 16, 0, 16),
            Title = "Premium Mode",
            Subtitle = "Semua fitur lengkap, kontrol kustom, dan tampilan dashboard pro."
        })

        UI.CreateIconButton(sectionB.Body, {
            Name = "PremiumIcon",
            Position = UDim2.new(0, 0, 0, 0),
            IconText = "P",
            BackgroundColor3 = Color3.fromRGB(255, 176, 63)
        })

        local premiumKeyBox = Instance.new("TextBox")
        premiumKeyBox.Name = "PremiumKeyInput"
        premiumKeyBox.Parent = sectionB.Body
        premiumKeyBox.Size = UDim2.new(0.95, 0, 0, 42)
        premiumKeyBox.Position = UDim2.new(0, 8, 0, 78)
        premiumKeyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        premiumKeyBox.TextColor3 = Color3.fromRGB(23, 33, 57)
        premiumKeyBox.PlaceholderText = "Masukkan premium key Anda"
        premiumKeyBox.Font = Enum.Font.Gotham
        premiumKeyBox.TextSize = 16
        premiumKeyBox.ClearTextOnFocus = false

        local submitButton = UI.CreateButton(sectionB.Body, {
            Name = "PremiumSubmit",
            Position = UDim2.new(0, 0, 0, 136),
            Text = "Verifikasi Key",
            Size = UDim2.new(0, 180, 0, 42),
            BackgroundColor3 = Color3.fromRGB(28, 92, 212),
            HoverColor = Color3.fromRGB(21, 72, 168),
            OnClick = function()
                local inputKey = premiumKeyBox.Text
                local valid, result = SupabaseClient.ValidatePremiumKey(inputKey)
                if valid then
                    UI.CreateNotification(game.CoreGui, {
                        Title = "Premium Aktif",
                        Message = "Key valid. Akses premium diaktifkan.",
                        Duration = 4
                    })
                    print("Premium key valid", result)
                else
                    UI.CreateNotification(game.CoreGui, {
                        Title = "Premium Gagal",
                        Message = "Key tidak valid atau jaringan bermasalah.",
                        Duration = 4
                    })
                    warn("Premium validation failed:", result)
                end
            end
        })

        local remoteButton = UI.CreateButton(sectionB.Body, {
            Name = "PremiumRemoteLoad",
            Position = UDim2.new(0, 196, 0, 136),
            Text = "Load Remote Script",
            Size = UDim2.new(0, 180, 0, 42),
            BackgroundColor3 = Color3.fromRGB(76, 142, 255),
            HoverColor = Color3.fromRGB(57, 112, 215),
            OnClick = function()
                local success, result = SupabaseClient.FetchRemoteLoaderScript()
                if success then
                    UI.CreateNotification(game.CoreGui, {
                        Title = "Remote Loaded",
                        Message = "Loader dari Supabase berhasil dijalankan.",
                        Duration = 4
                    })
                else
                    UI.CreateNotification(game.CoreGui, {
                        Title = "Remote Gagal",
                        Message = tostring(result),
                        Duration = 5
                    })
                end
            end
        })
    end)

    return window
end

return LoaderMenu
