
local funcs = {}

function funcs.tween(inst, tweeninfo, propTable)
    game:GetService("TweenService"):Create(inst, tweeninfo, propTable):Play()
end

-- ill add more later.

return funcs