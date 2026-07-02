local Utils = GithubRequire("UI/MainUI/Core/Utils.lua")

local RoundedFrame = {}

function RoundedFrame.new(parent, props)
    return Utils.CreateRoundedFrame(parent, {
        Name = props.Name,
        Position = props.Position,
        AnchorPoint = props.AnchorPoint,
        Size = props.Size,
        BackgroundColor3 = props.BackgroundColor3,
        BackgroundTransparency = props.BackgroundTransparency,
        CornerRadius = props.CornerRadius or UDim.new(0, 20),
        UIStroke = props.UIStroke,
        UIGradient = props.UIGradient,
        ZIndex = props.ZIndex
    })
end

return RoundedFrame
