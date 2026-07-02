local Theme = GithubRequire("UI/MainUI/Core/Theme.lua")
local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")
local Window = GithubRequire("UI/MainUI/Components/Window.lua")
local Button = GithubRequire("UI/MainUI/Components/Button.lua")
local TabView = GithubRequire("UI/MainUI/Components/TabView.lua")
local IconButton = GithubRequire("UI/MainUI/Components/IconButton.lua")
local Section = GithubRequire("UI/MainUI/Components/Section.lua")
local ColorPicker = GithubRequire("UI/MainUI/Components/ColorPicker.lua")
local BrandIcon = GithubRequire("UI/MainUI/Components/BrandIcon.lua")
local CommandCard = GithubRequire("UI/MainUI/Components/CommandCard.lua")
local Toggle = GithubRequire("UI/MainUI/Components/Toggle.lua")
local Slider = GithubRequire("UI/MainUI/Components/Slider.lua")
local AutoButton = GithubRequire("UI/MainUI/Components/AutoButton.lua")
local Notification = GithubRequire("UI/MainUI/Components/Notification.lua")

local UI = {
    Theme = Theme,
    Utils = Utils,
    Components = {
        Window = Window,
        Button = Button,
        TabView = TabView,
        IconButton = IconButton,
        Section = Section,
        ColorPicker = ColorPicker,
        BrandIcon = BrandIcon,
        CommandCard = CommandCard,
        Toggle = Toggle,
        Slider = Slider,
        AutoButton = AutoButton,
        Notification = Notification
    }
}

function UI.CreateWindow(options)
    return Window.new(options or {})
end

function UI.CreateButton(parent, options)
    return Button.new(parent, options or {})
end

function UI.CreateTabView(parent)
    return TabView.new(parent)
end

function UI.CreateIconButton(parent, options)
    return IconButton.new(parent, options or {})
end

function UI.CreateSection(parent, options)
    return Section.new(parent, options or {})
end

function UI.CreateColorPicker(parent, options)
    return ColorPicker.new(parent, options or {})
end

function UI.CreateBrandIcon(parent, options)
    return BrandIcon.new(parent, options or {})
end

function UI.CreateCommandCard(parent, options)
    return CommandCard.new(parent, options or {})
end

function UI.CreateToggle(parent, options)
    return Toggle.new(parent, options or {})
end

function UI.CreateSlider(parent, options)
    return Slider.new(parent, options or {})
end

function UI.CreateAutoButton(parent, options)
    return AutoButton.new(parent, options or {})
end

function UI.CreateNotification(parent, options)
    return Notification.new(parent or game.CoreGui, options or {})
end

return UI
