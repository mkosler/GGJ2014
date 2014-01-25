local bit32 = require("lib.numberlua")
local Class = require("lib.hump.class")

local Level = Class{}
function Level:init(world, filepath, tilewidth, tileheight)
    self.world = world

    self.filepath = filepath

    self.tilewidth = tilewidth
    self.tileheight = tileheight

    self.tiles = {}
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
    self.canvas = love.graphics.newCanvas(self.rows * self.tilewidth, self.columns * self.tileheight)

    love.graphics.setCanvas(self.canvas)
    for _,tile in ipairs(self.tiles) do
        if tile.body then
            local x, y = tile.fixture:getBoundingBox()

            if tile.isNeutralSolid then
                love.graphics.setColor(0, 255, 0)
                love.graphics.rectangle("fill", x, y, self.tilewidth / 3, self.tileheight)
            end

            if tile.isHappySolid then
                love.graphics.setColor(0, 0, 255)
                love.graphics.rectangle("fill", x + self.tilewidth / 3, y, self.tilewidth / 3, self.tileheight)
            end

            if tile.isSadSolid then
                love.graphics.setColor(255, 0, 0)
                love.graphics.rectangle("fill", x + 2 * self.tilewidth / 3, y, self.tilewidth / 3, self.tileheight)
            end

            love.graphics.setColor(255, 255, 255)
            love.graphics.polygon("line", tile.body:getWorldPoints(tile.shape:getPoints()))
        end
    end
    love.graphics.setCanvas()
end

function Level:draw()
    love.graphics.draw(self.canvas, 0, 0)
end

return Level
