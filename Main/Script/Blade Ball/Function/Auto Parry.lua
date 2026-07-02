local AutoParry = {}

autoParryEnabled = false

function AutoParry.SetEnabled(value)
    autoParryEnabled = value and true or false
    print("Auto Parry", autoParryEnabled and "enabled" or "disabled")
end

function AutoParry.IsEnabled()
    return autoParryEnabled
end

function AutoParry.Execute()
    if not autoParryEnabled then
        return
    end

    print("Auto Parry executed")
    -- Tambahkan logika bypass / eksekusi secara periodik di sini.
end

return AutoParry
