math.randomseed(os.time())
math.random(); math.random(); math.random()

local Camera = require("lib.hump.camera")
local Gamestate = require("lib.hump.gamestate")
local Timer = require("lib.hump.timer")

function love.load()
    INIT = require("init")
    LEVELS = INIT.LEVELS

    Play = require("src.states.play")
    Title = require("src.states.title")

    camera = Camera()
    camera:zoomTo(2)

    INIT.MAIN_THEME:setLooping(true)
    INIT.MAIN_THEME:play()

    Gamestate.registerEvents()
    Gamestate.switch(Title)
    --Gamestate.switch(Play, LEVELS[1].PATH)
end

function love.update(dt)
    Timer.update(dt)
end

function love.keypressed(key, code)
    if key == "escape" then
        love.event.quit()
    end
end
