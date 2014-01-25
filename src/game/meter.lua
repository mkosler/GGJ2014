local Class = require("lib.hump.class")

local Meter = Class{}
function Meter:init(emotion)
    self.emotion = emotion
    self.max = 100
    self.value = self.max
    self.regenerationRate = 50
end

function Meter:regenerate(dt)
    self.value = self.value + self.regenerationRate * dt

    if self.value >= self.max then
        self.value = self.max
    end
end

function Meter:degenerate(dt)
    self.value = self.value - self.regenerationRate * dt

    if self.value <= 0 then
        self.value = 0
    end
end

function Meter:getPercentage()
    return self.value / self.max
end

return Meter
