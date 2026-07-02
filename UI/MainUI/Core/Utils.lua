local Utils = {}

function Utils.create(className, props)
    local instance = Instance.new(className)

    if props then
        for property, value in pairs(props) do
            if property ~= "Parent" then
                instance[property] = value
            end
        end

        if props.Parent then
            instance.Parent = props.Parent
        end
    end

    return instance
end

function Utils.setProperties(instance, props)
    if not instance or not props then
        return
    end

    for property, value in pairs(props) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
end

function Utils.CreateGradient(parent, props)
    local gradient = Utils.create("UIGradient", {
        Parent = parent,
        Color = props.Color or ColorSequence.new(Color3.new(1, 1, 1)),
        Transparency = props.Transparency or NumberSequence.new(0.4),
        Rotation = props.Rotation or 0
    })

    return gradient
end

function Utils.CreateRoundedFrame(parent, props)
    local frame = Utils.create("Frame", {
        Parent = parent,
        Name = props.Name or "RoundedFrame",
        Size = props.Size or UDim2.new(1, 1, 1, 1),
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        BackgroundColor3 = props.BackgroundColor3 or Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = props.BackgroundTransparency or 0,
        BorderSizePixel = 0,
        ZIndex = props.ZIndex or 1
    })

    Utils.create("UICorner", {
        Parent = frame,
        CornerRadius = props.CornerRadius or UDim.new(0, 20)
    })

    if props.UIStroke then
        Utils.create("UIStroke", {
            Parent = frame,
            Color = props.UIStroke.Color,
            Thickness = props.UIStroke.Thickness or 1,
            Transparency = props.UIStroke.Transparency or 0.6
        })
    end

    if props.UIGradient then
        Utils.CreateGradient(frame, props.UIGradient)
    end

    return frame
end

return Utils
