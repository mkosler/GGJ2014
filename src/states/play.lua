local Gamestate = require("lib.hump.gamestate")
local Level = require("src.game.level")
local Player = require("src.game.player")
local Text = require("src.game.text")

local Play = {}

function Play.beginContact(a, b, coll)
    local aud, bud = a:getUserData(), b:getUserData()

    if aud == "foot" or bud == "foot" then
        Play.player.flags.jumping = false
    end

    if aud == "foot" and bud and bud.name == "Exit" or
       aud and aud.name == "Exit" and bud == "foot" then
       love.event.quit()
    end

    if aud and aud.name == "Terminal" then
        Play.player:setTerminal(a, aud.type)
    elseif bud and bud.name == "Terminal" then
        Play.player:setTerminal(b, bud.type)
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
    self.world = love.physics.newWorld(0, 9.81 * 50, true)
    love.physics.setMeter(50)
end

function Play:enter(previous)
    self.world:setCallbacks(Play.beginContact, Play.endContact, Play.preSolve, Play.postSolve)

    self.level = Level(self.world, "assets.maps.level1")
    self.level:load()

    self.player = Player(self.world, 30, 100)
    self.player:setLevel(self.level)
end

function Play:leave()
    love.event.quit()
end

function Play:update(dt)
    self.world:update(dt)
    self.level:update(dt)
    self.player:update(dt)
end

function Play:draw()
    self.level:draw()
    self.player:draw()
end

function Play:keypressed(key, code)
    self.player:keypressed(key, code)
end

function Play:keyreleased(key, code)
    self.player:keyreleased(key, code)
end

return Play
