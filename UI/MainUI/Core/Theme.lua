local Theme = {
    Colors = {
        Background = Color3.fromRGB(54, 180, 255),
        Surface = Color3.fromRGB(245, 249, 255),
        Primary = Color3.fromRGB(18, 110, 255),
        Secondary = Color3.fromRGB(198, 216, 255),
        Accent = Color3.fromRGB(255, 197, 63),
        Text = Color3.fromRGB(21, 33, 63),
        Muted = Color3.fromRGB(110, 126, 156),
        Light = Color3.fromRGB(255, 255, 255)
    }
}

function Theme.LightGradient()
    return ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 241, 255))
    }
end

function Theme.SoftGradient()
    return ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(236, 249, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }
end

return Theme
