local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")
local Button = GithubRequire("UI/MainUI/Components/Button.lua")

local TabView = {}

function TabView.new(parent)
    local container = Utils.CreateRoundedFrame(parent, {
        Name = "TabViewContainer",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Colors.Surface,
        CornerRadius = UDim.new(0, 20),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.7}
    })

    local sidebar = Utils.CreateRoundedFrame(container, {
        Name = "TabSidebar",
        Size = UDim2.new(0, 220, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Colors.Background,
        CornerRadius = UDim.new(0, 20),
        UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.65}
    })

    local tabButtons = Utils.create("Frame", {
        Parent = sidebar,
        Name = "TabButtons",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 1, -24),
        Position = UDim2.new(0, 12, 0, 12),
        ClipsDescendants = true
    })

    local pageHolder = Utils.create("Frame", {
        Parent = container,
        Name = "PageHolder",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -240, 1, -24),
        Position = UDim2.new(0, 230, 0, 12)
    })

    local pages = {}
    local currentTab = nil

    local function selectTab(tabName)
        for pageName, pageData in pairs(pages) do
            pageData.Page.Visible = pageName == tabName
            pageData.Button.BackgroundColor3 = pageName == tabName and Theme.Colors.Primary or Theme.Colors.Background
            pageData.Button.TextColor3 = pageName == tabName and Color3.fromRGB(255, 255, 255) or Theme.Colors.Text
        end
        currentTab = tabName
    end

    function container:AddTab(tabName, callback)
        local button = Button.new(tabButtons, {
            Name = tabName .. "TabButton",
            Size = UDim2.new(1, 0, 0, 46),
            Position = UDim2.new(0, 0, 0, #pages * 52),
            BackgroundColor3 = Theme.Colors.Background,
            Text = tabName,
            TextColor3 = Theme.Colors.Text,
            HoverColor = Color3.fromRGB(220, 235, 255),
            ZIndex = 2
        })

        local page = Utils.CreateRoundedFrame(pageHolder, {
            Name = tabName .. "Page",
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = Theme.Colors.Surface,
            CornerRadius = UDim.new(0, 18),
            BackgroundTransparency = 0,
            UIStroke = {Color = Theme.Colors.Secondary, Thickness = 1, Transparency = 0.7}
        })

        page.Visible = false
        page.ClipsDescendants = true

        button.MouseButton1Click:Connect(function()
            selectTab(tabName)
        end)

        pages[tabName] = {
            Page = page,
            Button = button
        }

        if type(callback) == "function" then
            callback(page)
        end

        if not currentTab then
            selectTab(tabName)
        end

        return page
    end

    return container
end

return TabView
