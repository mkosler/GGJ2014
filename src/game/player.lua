local Class = require("lib.hump.class")

local Player = Class{}
function Player:init(world, x, y, width, height)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newRectangleShape(width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.body:setFixedRotation(true)
end

function Player:draw()
    love.graphics.setColor(255, 255, 0)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

return Player
