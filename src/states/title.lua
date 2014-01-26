local Button = require("src.gui.button")
local Gamestate = require("lib.hump.gamestate")

local Title = {}

function Title:init()
end

function Title:enter(previous)
    local x = love.window.getWidth() / 2 - 300 / 2 - 10 / 2

    self.buttons = {
        Button(x, love.window.getHeight() - 50, 100, 30, "Play", 16),
        Button(x + 200 + 20, love.window.getHeight() - 50, 100, 30, "Exit", 16),
    }

    self.buttons[1].callback = function ()
        Gamestate.switch(Play, LEVELS[1].PATH)
    end

    self.buttons[2].callback = function ()
        love.event.quit()
    end

    self.title = {}
    self.title.text = "TOUGHEN UP, ROBOT!"
    self.title.x = love.window.getWidth() / 2 - INIT.TITLE_FONTS[44]:getWidth(self.title.text) / 2
    self.title.y = 25
end

function Title:leave()
end

function Title:draw()
    for i,button in ipairs(self.buttons) do
        button:draw()
    end

    love.graphics.setFont(INIT.TITLE_FONTS[44])
    love.graphics.print(self.title.text, self.title.x, self.title.y)

    love.graphics.setFont(INIT.FONTS[24])
    love.graphics.printf([[
Made by:
Michael Kosler for GGJ2014

Created with:
LOVE (http://love2d.org)

Hosted by:
Austin Creative Alliance 31

Sponsored by:
IGDA Austin, Captivate Conference, and Bryon Lloyd
]], self.title.x, self.title.y + 75, love.window.getWidth() - 50, "center")
end

function Title:mousereleased(x, y, button)
    for i,b in ipairs(self.buttons) do
        b:mousereleased(x, y, button)
    end
end

return Title
