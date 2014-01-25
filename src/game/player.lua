local Class = require("lib.hump.class")

local PLAYER = require("init").PLAYER

local Player = Class{}
function Player:init(world, x, y)
    self.image = PLAYER.IMAGE

    self.moods = {
        neutral = love.graphics.newQuad(0, 0, PLAYER.WIDTH, PLAYER.HEIGHT, self.image:getWidth(), self.image:getHeight()),
        happy = love.graphics.newQuad(PLAYER.WIDTH, 0, PLAYER.WIDTH, PLAYER.HEIGHT, self.image:getWidth(), self.image:getHeight()),
        sad = love.graphics.newQuad(PLAYER.WIDTH * 2, 0, PLAYER.WIDTH, PLAYER.HEIGHT, self.image:getWidth(), self.image:getHeight()),
    }

    self.moods.current = self.moods.neutral

    self.terminal = nil

    self.flags = {
        left = false,
        right = false,
        up = false,
        [" "] = false,
        jumping = false,
    }

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newRectangleShape(PLAYER.WIDTH, PLAYER.HEIGHT)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.body:setFixedRotation(true)

    self.foot = {}
    self.foot.shape = love.physics.newRectangleShape(0, PLAYER.HEIGHT / 2, PLAYER.WIDTH / 4, PLAYER.HEIGHT / 4)
    self.foot.fixture = love.physics.newFixture(self.body, self.foot.shape)

    self.foot.fixture:setSensor(true)
    self.foot.fixture:setUserData("foot")
end

function Player:setLevel(level)
    self.level = level
end

function Player:setTerminal(terminal, mood)
    self.terminal = terminal
    self.terminalMood = mood
end

function Player:setMood(mood)
    self.moods.current = self.moods[mood]
end

function Player:update(dt)
    if self.flags.left then
        local IMPULSE = PLAYER.PHYSICS.IMPULSES.LEFT

        self.body:applyLinearImpulse(IMPULSE[1] * self.body:getMass(), IMPULSE[2] * self.body:getMass())
    elseif self.flags.right then
        local IMPULSE = PLAYER.PHYSICS.IMPULSES.RIGHT

        self.body:applyLinearImpulse(IMPULSE[1] * self.body:getMass(), IMPULSE[2] * self.body:getMass())
    end

    if self.flags[" "] and not self.flags.jumping then
        local IMPULSE = PLAYER.PHYSICS.IMPULSES.JUMP

        self.flags.jumping = true

        self.body:applyLinearImpulse(IMPULSE[1] * self.body:getMass(), IMPULSE[2] * self.body:getMass())
    end

    if self.flags.up and self.terminal then
        self.terminal:setUserData("start")
        self.terminal = nil

        self:setMood(self.terminalMood)
        self.level:setMood(self.terminalMood)

        --[[
        local mood = self.terminal.mood:lower()

        self:setMood(mood)
        self.level:setMood(mood)
        ]]
    end
end

function Player:draw()
    love.graphics.setColor(255, 255, 255)

    local x, y = self.fixture:getBoundingBox()
    love.graphics.draw(self.image, self.moods.current, x, y)
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
