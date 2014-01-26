local Class = require("lib.hump.class")
local Text = require("src.game.text")
local Timer = require("lib.hump.timer")

local FACES = INIT.FACES

local Plaque = Class{}
function Plaque:init(x, y, width, height, textSize)
    self.moods = {
        sad = FACES.SAD,
        neutral = FACES.NEUTRAL,
        happy = FACES.HAPPY,
    }

    self.moods.current = self.moods.neutral

    self.terminalFace = FACES.TERMINAL

    self.image = self.moods.current

    self.x = x
    self.y = y

    self.width = width
    self.height = height

    self.text = nil
    self.textSize = textSize
end

function Plaque:setImage(which)
    if which == "player" then
        self.image = self.moods.current
    elseif which == "terminal" then
        self.image = self.terminalFace
    end
end

function Plaque:setMood(mood)
    self.moods.current = self.moods[mood]
end

function Plaque:start(mood)
    self.text = Text(mood, self.textSize, self.width - self.image:getWidth() - 5)
    local time = self.text:start()
    self:setImage("terminal")

    Timer.add(time, function ()
        self:setImage("player")
    end)
end

function Plaque:draw()
    local x, y = self.x, self.y

    self:drawBackground(x, y)

    love.graphics.draw(self.image, x, y)
    if self.text then
        self.text:draw(x + self.image:getWidth() + 5, y + 5)
    end
end

function Plaque:drawBackground(x, y)
    local lw = love.graphics.getLineWidth()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setLineWidth(10)

    love.graphics.setColor(160, 160, 160)
    love.graphics.rectangle("fill", x, y, self.width, self.height)

    love.graphics.setColor(64, 64, 64)
    love.graphics.rectangle("line", x + 1, y + 1, self.width - 2, self.height - 2)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", x, y, self.width, self.height)

    love.graphics.setColor(r, g, b, a)
    love.graphics.setLineWidth(lw)
end

return Plaque
