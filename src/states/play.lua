local Camera = require("lib.hump.camera")
local Gamestate = require("lib.hump.gamestate")
local Level = require("src.game.level")
local Plaque = require("src.game.plaque")
local Player = require("src.game.player")
local Text = require("src.game.text")
local Timer = require("lib.hump.timer")

local Play = {}

function Play.beginContact(a, b, coll)
    local aud, bud = a:getUserData(), b:getUserData()

    if aud == "foot" or bud == "foot" then
        Play.player.flags.jumping = false
    end

    if aud == "foot" and bud and bud.name == "Exit" or
       aud and aud.name == "Exit" and bud == "foot" then
       Play.isFinished = true
    end

    if aud and aud.name == "Terminal" then
        Play.player:setTerminal(a, aud.type)
    elseif bud and bud.name == "Terminal" then
        Play.player:setTerminal(b, bud.type)
    end

    if aud and aud.name == "Button" then
        a:setUserData("press")
    elseif bud and bud.name == "Button" then
        b:setUserData("press")
    end
end

function Play.endContact(a, b, coll)
    local aud, bud = a:getUserData(), b:getUserData()

    if (aud and aud.name == "Terminal") or (bud and bud.name == "Terminal") then
        Play.player:setTerminal()
    end
end

function Play.preSolve(a, b, coll)
end

function Play.postSolve(a, b, coll)
end

function Play:init()
    self.number = 1
end

function Play:enter(previous, filepath)
    local r,g,b,a = love.graphics.getColor()
    self.color = { r, g, b, 0 }

    self.world = love.physics.newWorld(0, 9.81 * 50, true)
    self.world:setCallbacks(Play.beginContact, Play.endContact, Play.preSolve, Play.postSolve)
    love.physics.setMeter(50)

    self.level = Level(self.world, filepath)
    self.level:load()

    local x, y = self.level:getEntrance()

    self.plaque = Plaque(0, love.window.getHeight() - 100, love.window.getWidth(), 100, 24)

    self.player = Player(self.world, x, y, self.plaque)
    self.player:setLevel(self.level)

    self.isFinished = false

    Timer.tween(1, self.color, { 255, 255, 255, 255 })
end

function Play:leave()
    self.world:destroy()
end

function Play:update(dt)
    local px, py = self.player.body:getPosition()
    camera:lookAt(px, py)

    self.world:update(dt)
    self.level:update(dt)
    self.player:update(dt)

    if self.isFinished then
        self.isFinished = false

        self.number = self.number + 1

        local color = { 255, 255, 255, 255 }

        --[[
        Timer.tween(1, self.color, { 255, 255, 255, 0 }, "linear", function ()
            Gamestate.switch(Play, LEVELS[self.number].PATH)
        end)
        ]]

        Gamestate.switch(Play, LEVELS[self.number].PATH)
    end
end

function Play:draw()
    love.graphics.setColor(self.color)

    camera:attach()

    self.level:draw()
    self.player:draw()

    camera:detach()

    self.plaque:draw()
end

function Play:keypressed(key, code)
    if key == "r" then
        Gamestate.switch(Play, LEVELS[self.number].PATH)
    end

    self.player:keypressed(key, code)
end

function Play:keyreleased(key, code)
    self.player:keyreleased(key, code)
end

return Play
