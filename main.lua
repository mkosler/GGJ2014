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
    level = Level(world, "assets.maps.level1")
    level:load()
    player = Player(world, 100, 100)
end

function love.update(dt)
    world:update(dt)
    player:update(dt)

    --[[
    if player.flags.happy then
        level:setCanvas("happy")
    elseif player.flags.sad then
        level:setCanvas("sad")
    else
        level:setCanvas("neutral")
    end
    ]]
end

function love.draw()
    love.graphics.scale(3, 3)

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
