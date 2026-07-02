local UI = GithubRequire("UI/MainUI/MainUI.lua")
local AutoMergeNuke = GithubRequire("Main/Script/Merge a Nuke/Function/Auto Merge Nuke.lua")

print("Merge A Nuke: script loaded")

local function buildMergeANukeMenu()
    local window = UI.CreateWindow({
        Parent = game.CoreGui,
        Name = "OceanHubMergeANukeMenu",
        Title = "Merge A Nuke",
        Size = UDim2.new(0, 760, 0, 460),
        Position = UDim2.new(0.5, -380, 0.5, -230),
        BackgroundColor3 = Color3.fromRGB(14, 20, 34),
        LogoImage = "rbxassetid://1887484881"
    })

    local header = UI.CreateSection(window.Content, {
        Name = "MergeNukeHeader",
        Size = UDim2.new(1, -32, 0, 148),
        Position = UDim2.new(0, 16, 0, 16),
        Title = "Merge A Nuke",
        Subtitle = "Aktifkan auto merge untuk memproses nuke secara otomatis di dalam game.",
        BackgroundColor3 = Color3.fromRGB(18, 24, 42),
        TitleColor = Color3.fromRGB(255, 255, 255),
        SubtitleColor = Color3.fromRGB(170, 182, 204)
    })

    header.Root.BackgroundTransparency = 0.02
    header.Root.UIStroke.Color = Color3.fromRGB(85, 106, 150)

    local autoMergeToggle = UI.CreateToggle(header.Body, {
        Name = "AutoMergeToggle",
        Position = UDim2.new(0, 0, 0, 12),
        Label = "Enable Auto Merge",
        DefaultOn = false,
        SwitchOnColor = Color3.fromRGB(0, 198, 161),
        SwitchOffColor = Color3.fromRGB(93, 102, 128),
        OnToggle = function(isOn)
            AutoMergeNuke.SetEnabled(isOn)
            print("Merge A Nuke: Auto merge toggle set to", isOn)
        end
    })

    UI.CreateButton(header.Body, {
        Name = "RunMergeButton",
        Position = UDim2.new(0, 0, 0, 84),
        Size = UDim2.new(0, 240, 0, 46),
        Text = "Run Merge Now",
        BackgroundColor3 = Color3.fromRGB(40, 130, 255),
        HoverColor = Color3.fromRGB(25, 100, 220),
        TextSize = 16,
        OnClick = function()
            AutoMergeNuke.Execute()
            print("Merge A Nuke: Run Merge Now clicked")
        end
    })

    UI.CreateButton(header.Body, {
        Name = "DebugScanButton",
        Position = UDim2.new(0, 260, 0, 84),
        Size = UDim2.new(0, 240, 0, 46),
        Text = "Debug Scan",
        BackgroundColor3 = Color3.fromRGB(255, 146, 42),
        HoverColor = Color3.fromRGB(210, 110, 25),
        TextSize = 16,
        OnClick = function()
            local results = AutoMergeNuke.DebugScan()
            print("Merge A Nuke: Debug Scan results found", #results)
            for _, entry in ipairs(results) do
                print("-", entry.Class, entry.Path)
            end
        end
    })

    local noteSection = UI.CreateSection(window.Content, {
        Name = "MergeNukeNote",
        Size = UDim2.new(1, -32, 0, 160),
        Position = UDim2.new(0, 16, 0, 180),
        Title = "Catatan Penggunaan",
        Subtitle = "Gunakan auto merge ketika Anda siap memproses nuke. Hentikan jika terjadi masalah performa.",
        BackgroundColor3 = Color3.fromRGB(12, 16, 28),
        TitleColor = Color3.fromRGB(255, 255, 255),
        SubtitleColor = Color3.fromRGB(175, 184, 205)
    })

    local infoText = Instance.new("TextLabel")
    infoText.Parent = noteSection.Body
    infoText.Size = UDim2.new(1, 0, 1, 0)
    infoText.Position = UDim2.new(0, 0, 0, 0)
    infoText.BackgroundTransparency = 1
    infoText.Text = "Auto merge akan memicu fungsi merge bila diaktifkan. Tekan Run Merge Now untuk eksekusi manual." ..
        " Pastikan Anda berada di area yang benar sebelum menyalakan auto merge."
    infoText.TextColor3 = Color3.fromRGB(180, 190, 205)
    infoText.Font = Enum.Font.Gotham
    infoText.TextSize = 14
    infoText.TextWrapped = true
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.TextYAlignment = Enum.TextYAlignment.Top
    infoText.ZIndex = 3

    print("Merge A Nuke: menu berhasil dibuat")
end

buildMergeANukeMenu()
