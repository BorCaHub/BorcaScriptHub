local AutoButton = {}

autoButtonEnabled = false

function AutoButton.SetEnabled(value)
    autoButtonEnabled = value and true or false
    print("Sell Lemons auto button", autoButtonEnabled and "enabled" or "disabled")
end

function AutoButton.IsEnabled()
    return autoButtonEnabled
end

function AutoButton.Execute()
    if not autoButtonEnabled then
        return
    end

    print("Sell Lemons auto button executed")
    -- Tambahkan logika tombol otomatis di sini.
end

return AutoButton
