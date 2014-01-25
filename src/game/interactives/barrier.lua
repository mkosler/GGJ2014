local Class = require("lib.hump.class")
local Interactive = require("src.game.interactives.interactive")

local Barrier = Class{ __includes = Interactive }
function Barrier:init(world, image, quad, object)
    Interactive.init(self, world, image, quad, object)
end

return Barrier
