local Class = require("lib.hump.class")
local Interactive = require("src.game.interactives.interactive")

local Exit = Class{ __includes = Interactive }
function Exit:init(world, image, quad, object)
    Interactive.init(self, world, image, quad, object)

    self.fixture:setSensor(true)
end

return Exit
