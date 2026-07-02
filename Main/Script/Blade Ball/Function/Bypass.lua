local Bypass = {}

local bypassEnabled = false

function Bypass.SetEnabled(value)
    bypassEnabled = value and true or false
    print("Blade Ball bypass", bypassEnabled and "enabled" or "disabled")
end

function Bypass.IsEnabled()
    return bypassEnabled
end

function Bypass.Execute()
    if not bypassEnabled then
        return
    end

    print("Blade Ball bypass execution running")
    -- Implementasi bypass yang diperlukan di sini.
end

return Bypass
