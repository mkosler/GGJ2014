local bit32 = require("lib.numberlua")
local Class = require("lib.hump.class")

local Level = Class{}
function Level:init(world, filepath, tilewidth, tileheight)
    self.world = world

    self.filepath = filepath

    self.tilewidth = tilewidth
    self.tileheight = tileheight

    self.tiles = {}
    self.canvases = {}
end

function Level:load()
    local contents = love.filesystem.read(self.filepath)

    local r, c = 0, 0

    for line in contents:gmatch("[^\n]+") do
        c = 0

        for tile in line:gmatch("%x+") do
            local x = c * self.tilewidth
            local y = r * self.tileheight

            local tile = {
                isNeutralSolid = bit32.btest(tile, 0x01),
                isHappySolid = bit32.btest(tile, 0x02),
                isSadSolid = bit32.btest(tile, 0x04),
                isEntrance = bit32.btest(tile, 0x08),
                requiresNeutralKey = bit32.btest(tile, 0x10),
                requiresHappyKey = bit32.btest(tile, 0x20),
                requiresSadKey = bit32.btest(tile, 0x40),
                isExit = bit32.btest(tile, 0x80),
            }

            if tile.isNeutralSolid or tile.isHappySolid or tile.isSadSolid then
                tile.body = love.physics.newBody(self.world, x + self.tilewidth / 2, y + self.tileheight / 2, "static")
                tile.shape = love.physics.newRectangleShape(self.tilewidth, self.tileheight)
                tile.fixture = love.physics.newFixture(tile.body, tile.shape)
            end

            table.insert(self.tiles, tile)

            c = c + 1
        end

        r = r + 1
    end

    self.rows, self.columns = r, c

    self:renderToCanvas()
end

function Level:renderToCanvas()
    self.canvases.neutral = love.graphics.newCanvas(self.rows * self.tilewidth, self.columns * self.tileheight)
    self.canvases.happy = love.graphics.newCanvas(self.rows * self.tilewidth, self.columns * self.tileheight)
    self.canvases.sad = love.graphics.newCanvas(self.rows * self.tilewidth, self.columns * self.tileheight)

    for _,tile in ipairs(self.tiles) do
        if tile.body then
            local x, y = tile.fixture:getBoundingBox()

            local function drawTile()
                love.graphics.setColor(255, 255, 255)
                love.graphics.polygon("fill", tile.body:getWorldPoints(tile.shape:getPoints()))
            end

            if tile.isNeutralSolid then
                self.canvases.neutral:renderTo(drawTile)
            end

            if tile.isHappySolid then
                self.canvases.happy:renderTo(drawTile)
            end

            if tile.isSadSolid then
                self.canvases.sad:renderTo(drawTile)
            end
        end
    end

    self.canvases.current = self.canvases.neutral
end

function Level:setCanvas(canvas)
    self.canvases.current = self.canvases[canvas]
end

function Level:draw()
    love.graphics.draw(self.canvases.current)
end

return Level
