local Class = require("lib.hump.class")
local Timer = require("lib.hump.timer")

local FONTS = INIT.FONTS
local TERMINALS = INIT.TERMINALS

local Text = Class{}
function Text:init(mood, size, limit)
    self.limit = limit
    self.mood = mood:upper()
    self.size = size or 12

    self.font = FONTS[self.size]
    love.graphics.setFont(self.font)

    local rand = math.random(#TERMINALS[self.mood])
    self.text = TERMINALS[self.mood][rand]

    self.visibleText = ""

    self.started = false
    self.attached = false
end

function Text:start()
    if self.started then return end
    self.started = true

    local j = 0

    Timer.addPeriodic(TERMINALS.TEXT_SPEED, function ()
        self.visibleText = self.text:sub(1, j)
        j = j + 1
    end, self.text:len() + 1)

    local total = TERMINALS.TEXT_SPEED * (self.text:len() + 1 + TERMINALS.BUFFER_LENGTH)

    return total
end

function Text:draw(x, y)
    if not self.started then return end

    love.graphics.printf(self.visibleText, x + 4, y + 4, self.limit)
end

return Text
