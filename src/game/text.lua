local Class = require("lib.hump.class")
local Timer = require("lib.hump.timer")

local FONTS = require("init").FONTS
local TERMINALS = require("init").TERMINALS

local Text = Class{}
function Text:init(mood, size)
    self.mood = mood:upper()
    self.size = size or 12

    self.font = FONTS[self.size]

    self.image = TERMINALS.IMAGE

    self.x = (love.window.getWidth() - self.image:getWidth()) / 2
    self.y = (love.window.getHeight() - self.image:getHeight()) / 2

    local rand = math.random(#TERMINALS[self.mood])
    self.text = TERMINALS[self.mood][rand]

    self.visibleText = ""

    self.started = false
    self.attached = false
end

function Text:reset()
    self.started = false
    self.attached = false
    self.visibleText = ""
end

function Text:start()
    if self.started then return end
    self.started = true

    local j = 0

    Timer.addPeriodic(0.15, function ()
        self.visibleText = self.text:sub(1, j)
        j = j + 1
    end, self.text:len() + 1)

    Timer.add(0.15 * (self.text:len() + 5), function () self:reset() end)
end

function Text:draw()
    if not self.started then return end

    love.graphics.setFont(self.font)

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.image, self.x, self.y)

    love.graphics.printf(self.visibleText, self.x + 4, self.y + 4, 88)
end

return Text
