local Class = require("lib.hump.class")
local Interactive = require("src.game.interactives.interactive")
local Text = require("src.game.text")

local Terminal = Class{ __includes = Interactive }
function Terminal:init(world, image, quad, object)
    Interactive.init(self, world, image, quad, object)

    self.fixture:setSensor(true)

    self.text = Text(object.type, 10)
end

function Terminal:update(dt)
    if self.fixture:getUserData() == "start" then
        self.text:start()
        self.fixture:setUserData(self.name)
    end
end

function Terminal:draw()
    Interactive.draw(self)
end

return Terminal
