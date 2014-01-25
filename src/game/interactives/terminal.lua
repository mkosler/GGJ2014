local Class = require("lib.hump.class")
local Interactive = require("src.game.interactives.interactive")

local Terminal = Class{ __includes = Interactive }
function Terminal:init(world, image, quad, object)
    Interactive.init(self, world, image, quad, object)

    self.fixture:setSensor(true)
end

function Terminal:setText(text)
    self.text = text
end

return Terminal
