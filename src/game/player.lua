local Class = require("lib.hump.class")

local Player = Class{}
function Player:init(world, x, y)
    self.image = love.graphics.newImage("assets/images/robot.png")

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newRectangleShape(width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.body:setFixedRotation(true)

    self.foot = {}
    self.foot.shape = love.physics.newRectangleShape(0, height / 2, width / 4, height / 4)
    self.foot.fixture = love.physics.newFixture(self.body, self.foot.shape)

    self.foot.fixture:setSensor(true)
    self.foot.fixture:setUserData("foot")

    self.flags = {
        left = false,
        right = false,
        [" "] = false,
        jumping = false,
        happy = false,
        sad = false,
    }
end

function Player:update(dt)
    if self.flags.left then
        self.body:applyLinearImpulse(-10 * self.body:getMass(), 0)
    elseif self.flags.right then
        self.body:applyLinearImpulse(10 * self.body:getMass(), 0)
    end

    if self.flags[" "] and not self.flags.jumping then
        self.flags.jumping = true
        self.body:applyLinearImpulse(0, -600 * self.body:getMass())
    end
end

function Player:draw()
    love.graphics.setColor(255, 255, 0)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Player:keypressed(key, code)
    for k,_ in pairs(self.flags) do
        if k == key then
            self.flags[key] = true
        end
    end
end

function Player:keyreleased(key, code)
    for k,_ in pairs(self.flags) do
        if k == key then
            self.flags[key] = false
        end
    end
end

return Player
