local Class = require("lib.hump.class")
local Meter = require("src.game.meter")

local Player = Class{}
function Player:init(world, x, y, width, height)
    self.width = width
    self.height = height

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newRectangleShape(width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.body:setFixedRotation(true)

    self.foot = {}
    self.foot.shape = love.physics.newRectangleShape(0, height / 2, width / 4, height / 4)
    self.foot.fixture = love.physics.newFixture(self.body, self.foot.shape)

    self.foot.fixture:setSensor(true)
    self.foot.fixture:setUserData("foot")

    self.meters = {
        happy = Meter("happy"),
        sad = Meter("sad"),
    }

    self.flags = {
        left = false,
        right = false,
        [" "] = false,
        jumping = false,
        ["1"] = false,
        ["2"] = false,
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

    if self.flags["1"] then
        self.flags.happy = true
        self.meters.happy:degenerate(dt)
    else
        self.flags.happy = false
        self.meters.happy:regenerate(dt)
    end

    if self.flags["2"] then
        self.flags.sad = true
        self.meters.sad:degenerate(dt)
    else
        self.flags.sad = false
        self.meters.sad:regenerate(dt)
    end
end

function Player:draw()
    love.graphics.setColor(255, 255, 0)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

    self:drawMeters()
end

function Player:drawMeters()
    local x, y = self.body:getPosition()

    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", x - self.width, y - self.height / 2, 10, self.height * self.meters.happy:getPercentage())

    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", x + self.width - 10, y - self.height / 2, 10, self.height * self.meters.sad:getPercentage())
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
