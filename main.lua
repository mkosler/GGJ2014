local Gamestate = require("lib.hump.gamestate")
local Timer = require("lib.hump.timer")

local Level = require("src.game.level")
local Player = require("src.game.player")

--[[ STATES ]]

--[[ FUNCTIONS ]]

function beginContact(a, b, coll)
    if a:getUserData() == "foot" or b:getUserData() == "foot" then
        player.flags.jumping = false
    end
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end

function love.load()
    world = love.physics.newWorld(0, 9.81 * 50, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    love.physics.setMeter(50)
    level = Level(world, "assets/maps/test.txt", 50, 50)
    level:load()
    player = Player(world, 100, 100, 25, 50)
end

function love.update(dt)
    world:update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    level:draw()
    player:draw()
end

function love.keypressed(key, code)
    if key == "escape" then
        love.event.quit()
    end

    player:keypressed(key, code)
end

function love.keyreleased(key, code)
    player:keyreleased(key, code)
end
