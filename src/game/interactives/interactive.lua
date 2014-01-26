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

    self.body:setY(self.body:getY() - self.height)

    self.fixture:setUserData({ name = self.name, type = self.type })
end

function Interactive:draw()
    if not self.body:isActive() then return end

    local x, y = self.fixture:getBoundingBox()
    x = math.ceil(x)
    y = math.ceil(y)

    love.graphics.draw(self.image, self.quad, x, y)
end

return Interactive
