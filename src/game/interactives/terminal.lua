local Class = require("lib.hump.class")
local Interactive = require("src.game.interactives.interactive")
local Text = require("src.game.text")

local TERMINALS = INIT.TERMINALS

local Terminal = Class{ __includes = Interactive }
function Terminal:init(world, image, quad, object)
    Interactive.init(self, world, image, quad, object)

    self.fixture:setSensor(true)

    self.used = false
end

function Terminal:update(dt)
    if not self.used and self.fixture:getUserData() == "used" then
        self.used = true
        self.image = TERMINALS.READ
    end
end

function Terminal:draw()
    if not self.used then
        Interactive.draw(self)
    else
        local x, y = self.fixture:getBoundingBox()
        x = math.ceil(x)
        y = math.ceil(y)

        love.graphics.draw(self.image, x, y)
    end
end

return Terminal
