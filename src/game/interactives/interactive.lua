local Class = require("lib.hump.class")

local Interactive = Class{}
function Interactive:init(world, image, quad, object)
    self.image = image
    self.quad = quad
    self.name = object.name
    self.type = object.type

    local _,_,w,h = quad:getViewport()

    self.width = w
    self.height = h

    self.body = love.physics.newBody(world, object.x + self.width / 2, object.y + self.height / 2, "static")
    self.shape = love.physics.newRectangleShape(self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setUserData({ name = self.name, type = self.type })
end

function Interactive:draw()
    if not self.body:isActive() then return end

    local x, y = self.fixture:getBoundingBox()
    x = math.floor(x)
    y = math.floor(y - self.height)

    love.graphics.draw(self.image, self.quad, x, y)
end

return Interactive
