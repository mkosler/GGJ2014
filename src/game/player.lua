local Class = require("lib.hump.class")

local PLAYER = INIT.PLAYER
local SOUNDS = INIT.SOUNDS

local Player = Class{}
function Player:init(world, x, y, plaque)
    self.plaque = plaque
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
    self.fixture:setUserData("Player")

    self.foot = {}
    self.foot.shape = love.physics.newRectangleShape(0, PLAYER.HEIGHT / 2, PLAYER.WIDTH / 4, PLAYER.HEIGHT / 4)
    self.foot.fixture = love.physics.newFixture(self.body, self.foot.shape)

    self.foot.fixture:setSensor(true)
    self.foot.fixture:setUserData("foot")
end

function Player:setLevel(level)
    self.level = level
    self.level:setMood("neutral")
end

function Player:setTerminal(terminal, mood)
    self.terminal = terminal
    self.terminalMood = mood
end

function Player:getMood()
    for k,v in pairs(self.moods) do
        if v == self.moods.current and k ~= "current" then
            return k
        end
    end
end

function Player:setMood(mood)
    local hierarchy = { "sad", "neutral", "happy" }
    local index = { sad = 1, neutral = 2, happy = 3 }
    local delta = 0

    if mood == "sad" then
        delta = -1
        SOUNDS.PLAYER.BLIPS.SAD:play()
    elseif mood == "neutral" then
        delta = 0
    elseif mood == "happy" then
        SOUNDS.PLAYER.BLIPS.HAPPY:play()
        delta = 1
    end

    local i = index[self:getMood()]

    local mName = hierarchy[i + delta]

    self.moods.current = self.moods[mName]
    self.plaque:setMood(mName)
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

        SOUNDS.PLAYER.JUMP:play()

        self.body:applyLinearImpulse(IMPULSE[1] * self.body:getMass(), IMPULSE[2] * self.body:getMass())
    end

    if self.flags.up then
        if self.terminal then
            self.terminal:setUserData("used")

            self.plaque:start(self.terminalMood)
            self.terminal = nil

            self:setMood(self.terminalMood)
            self.level:setMood(self:getMood())
        end
    end
end

function Player:draw()
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
