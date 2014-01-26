local Class = require("lib.hump.class")
local Interactive = require("src.game.interactives.interactive")

local Button = Class{ __includes = Interactive }
function Button:init(world, image, quad, object, onquad)
    Interactive.init(self, world, image, quad, object)

    self.offquad = quad
    self.onquad = onquad

    self.quad = self.offquad
    self.pressed = false
end

function Button:press()
    self.pressed = true
    self.quad = self.onquad

    INIT.SOUNDS.SWITCH:play()
end

function Button:update(dt)
    if self.fixture:getUserData() == "press" then
        self:press()

        self.fixture:setUserData({ name = self.name, type = self.type })
    end
end

return Button
