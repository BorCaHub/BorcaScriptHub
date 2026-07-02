local DeviceConfig = {}

local deviceModules = {
    PC = GithubRequire("Main/Loader/DeviceConfig/PC.lua"),
    Laptop = GithubRequire("Main/Loader/DeviceConfig/Laptop.lua"),
    Mac = GithubRequire("Main/Loader/DeviceConfig/Mac.lua"),
    HP = GithubRequire("Main/Loader/DeviceConfig/HP.lua"),
    Default = GithubRequire("Main/Loader/DeviceConfig/Default.lua")
}

local normalizedToKey = {
    pc = "PC",
    desktop = "PC",
    laptop = "Laptop",
    notebook = "Laptop",
    mac = "Mac",
    macbook = "Mac",
    hp = "HP"
}

function DeviceConfig.Get(deviceName)
    local normalized = type(deviceName) == "string" and deviceName:lower() or ""
    local key = normalizedToKey[normalized] or "Default"
    return deviceModules[key] or deviceModules.Default
end

return DeviceConfig
