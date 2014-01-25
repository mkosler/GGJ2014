local Class = require("lib.hump.class")
local Timer = require("lib.hump.timer")

local Animation = Class{}
function Animation:init(image, delay, mode)
    self.image = image

    self.imagewidth = image:getWidth()
    self.imageheight = image:getHeight()

    self.frames = {}
    self.index = 0
    self.totalFrames = 0

    self.timer = Timer.new()

    self.delay = delay

    self.handle = nil

    self.mode = mode or "loop"
    self.bounce = false

    self.flip = false
end

function Animation:reset()
    self.index = 0
    self.bounce = false
end

function Animation:addFrame(x, y, width, height, index)
    index = index or self.index

    self.frames[index] = love.graphics.newQuad(x, y, width, height, self.imagewidth, self.imageheight)

    self.index = self.index + 1
    self.totalFrames = self.index
end

function Animation:play()
    self:reset()

    if self.mode == "loop" then
        self.handle = self.timer:addPeriodic(self.delay, function ()
            self.index = (self.index + 1) % self.totalFrames
        end)
    elseif self.mode == "bounce" then
        self.handle = self.timer:addPeriodic(self.delay, function ()
            if self.index == self.totalFrames - 1 or self.index == 0 then
                self.bounce = not self.bounce
            end

            local dir = self.bounce and 1 or -1

            self.index = (self.index + dir) % self.totalFrames
        end)
    end
end

function Animation:stop()
    self.timer:cancel(self.handle)
end

function Animation:update(dt)
    self.timer:update(dt)
end

function Animation:nextFrame()
    self.index = (self.index + 1) % self.totalFrames
end

function Animation:prevFrame()
    self.index = (self.index - 1) % self.totalFrames
end

function Animation:draw(x, y)
    local sx = self.flip and -1 or 1
    local _,_,w,_ = self.frames[self.index]:getViewport()
    local ox = self.flip and w or 0

    love.graphics.draw(self.image, self.frames[self.index], x, y, 0, sx, 1, ox)
end

return Animation
