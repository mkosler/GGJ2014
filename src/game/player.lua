local Class = require("lib.hump.class")

local Player = Class{}
function Player:init(world, x, y)
    self.image = love.graphics.newImage("assets/images/robot.png")

    self.moods = {
        neutral = love.graphics.newQuad(0, 0, 16, 16, self.image:getWidth(), self.image:getHeight()),
        happy = love.graphics.newQuad(16, 0, 16, 16, self.image:getWidth(), self.image:getHeight()),
        sad = love.graphics.newQuad(32, 0, 16, 16, self.image:getWidth(), self.image:getHeight()),
    }

    self.moods.current = self.moods.neutral

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newRectangleShape(16, 16)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.body:setFixedRotation(true)

    self.foot = {}
    self.foot.shape = love.physics.newRectangleShape(0, 16 / 2, 16 / 4, 16 / 4)
    self.foot.fixture = love.physics.newFixture(self.body, self.foot.shape)

    self.foot.fixture:setSensor(true)
    self.foot.fixture:setUserData("foot")

    self.flags = {
        left = false,
        right = false,
        [" "] = false,
        jumping = false,
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
    love.graphics.setColor(255, 255, 255)

    local x, y = self.fixture:getBoundingBox()
    love.graphics.draw(self.image, self.moods.current, x, y)

    love.graphics.setColor(255, 0, 0)
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
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
