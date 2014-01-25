math.randomseed(os.time())
math.random(); math.random(); math.random()

local Gamestate = require("lib.hump.gamestate")
local Timer = require("lib.hump.timer")

--[[ STATES ]]

Play = require("src.states.play")

--[[ FUNCTIONS ]]

function love.load()
    require("init")

    Gamestate.registerEvents()
    Gamestate.switch(Play)
end

function love.update(dt)
    Timer.update(dt)
end

function love.keypressed(key, code)
    if key == "escape" then
        love.event.quit()
    end
end
