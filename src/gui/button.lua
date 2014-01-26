local Class = require("lib.hump.class")

local Button = Class{}
function Button:init(x, y, width, height, text, textSize)
    self.x = x
    self.y = y

    self.width = width
    self.height = height

    self.text = text
    self.font = INIT.FONTS[textSize]
end

function Button:draw()
    local color = { love.graphics.getColor() }
    local lw = love.graphics.getLineWidth()

    love.graphics.setLineWidth(10)

    love.graphics.setColor(160, 160, 160)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(64, 64, 64)
    love.graphics.rectangle("line", self.x + 1, self.y + 1, self.width - 2, self.height - 2)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(self.font)
    love.graphics.printf(self.text, self.x + 5, self.y + 5, self.width - 10, "center")
    
    love.graphics.setColor(color)
    love.graphics.setLineWidth(lw)
end

function Button:mousereleased(x, y, button)
    if button == "l" and
       self.x <= x and x <= self.x + self.width and
       self.y <= y and y <= self.y + self.height then
        if self.callback then self.callback() end
    end
end

return Button
