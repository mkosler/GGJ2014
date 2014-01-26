local Class = require("lib.hump.class")
local Interactive = require("src.game.interactives.interactive")

local Wall = Class{ __includes = Interactive }
function Wall:init(world, image, quad, object)
    Interactive.init(self, world, image, quad, object)
end

function Wall:setButton(button)
    self.button = button
end

function Wall:update(dt)
    if self.button.pressed then
        self.body:setActive(false)
    end
end

return Wall
