math.randomseed(os.time())
math.random(); math.random(); math.random()

local Gamestate = require("lib.hump.gamestate")
local Timer = require("lib.hump.timer")

local Level = require("src.game.level")
local Player = require("src.game.player")
local Text = require("src.game.text")

--[[ STATES ]]

--[[ FUNCTIONS ]]

function beginContact(a, b, coll)
    if a:getUserData() == "foot" or b:getUserData() == "foot" then
        player.flags.jumping = false
    end

    if a:getUserData() == "Terminal" or b:getUserData() == "Terminal" then
        player:setTerminal(terminalText)
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

    player = Player(world, 30, 100)
    player:setLevel(level)

    terminalText = Text("happy", 10)
end

function love.update(dt)
    Timer.update(dt)
    world:update(dt)
    player:update(dt)
end

function love.draw()
    level:draw()
    player:draw()
    terminalText:draw()
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
