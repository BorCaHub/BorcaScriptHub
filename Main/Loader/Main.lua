local MenuUI
local DeviceConfig

    -- Use GithubRequire (provided by bootstrap loader) instead of require(script.Parent...)
    local ok, mod = pcall(function()
        return GithubRequire("UI/MenuUI/init.lua")
    end)
    if ok and mod then
        MenuUI = mod
    else
        warn("Main/Loader/Main.lua: failed to GithubRequire UI/MenuUI/init.lua", mod)
    end
end

do
    local ok, mod = pcall(function()
        return GithubRequire("Main/Loader/DeviceConfig/ConfigManager.lua")
    end)
    if ok and mod then
        DeviceConfig = mod
    else
        warn("Main/Loader/Main.lua: failed to GithubRequire Main/Loader/DeviceConfig/ConfigManager.lua", mod)
    end
end

local function detectDeviceType()
    local camera = workspace.CurrentCamera
    local viewportSize = Vector2.new(1280, 720)

    if camera then
        viewportSize = camera.ViewportSize
    end

    if viewportSize.X >= 1600 then
        return "PC"
    elseif viewportSize.X >= 1400 then
        return "Laptop"
    elseif viewportSize.X >= 1200 then
        return "Mac"
    end

    return "Default"
end

-- Debug: print script ancestry to help diagnose nil Parent errors
local function getScriptAncestry()
    local parts = {}
    local node = script
    while node do
        table.insert(parts, node.Name)
        node = node.Parent
    end
    return table.concat(parts, "/")
end

print("Main/Loader/Main.lua running from:", getScriptAncestry())

local deviceConfig = nil
if DeviceConfig and type(DeviceConfig.Get) == "function" then
    deviceConfig = DeviceConfig.Get(detectDeviceType())
else
    warn("Main/Loader/Main.lua: DeviceConfig module missing or invalid; using default config table")
    deviceConfig = { Name = "Default", WindowSize = UDim2.new(0, 780, 0, 480), WindowPosition = UDim2.new(0.5, -390, 0.5, -240) }
end

if MenuUI and MenuUI.LoaderMenu and type(MenuUI.LoaderMenu.build) == "function" then
    local ok, err = pcall(function()
        MenuUI.LoaderMenu.build(game.CoreGui, deviceConfig)
    end)
    if not ok then
        warn("Main/Loader/Main.lua: LoaderMenu.build failed:", err)
    end
else
    warn("Main/Loader/Main.lua: MenuUI.LoaderMenu.build not available; check MenuUI module")
end
