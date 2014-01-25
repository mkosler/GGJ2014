local Gamestate = require("lib.hump.gamestate")
local Timer = require("lib.hump.timer")

local Level = require("src.game.level")

--[[ STATES ]]

--[[ FUNCTIONS ]]
function love.load()
    world = love.physics.newWorld(0, 9.81 * 50, true)
    love.physics.setMeter(50)
    level = Level(world, "assets/maps/test.txt", 50, 50)
    level:load()
end

function love.update(dt)
end

function love.draw()
    level:draw()
end

function love.keypressed(key, code)
    if key == "escape" then
        love.event.quit()
    end
end
