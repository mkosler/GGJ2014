local Class = require("lib.hump.class")

local Level = Class{}
function Level:init(world, filepath)
    self.world = world
    self.filepath = filepath
end

function Level:load()
    self.data = require(self.filepath)

    self:loadTilesets()
    self:loadLayers()
end

function Level:loadTilesets()
    self.tilesets = {}

    for _,tileset in ipairs(self.data.tilesets) do
        local ts = {}

        ts.image = love.graphics.newImage(tileset.image)
        ts.quads = self:createQuads(tileset, ts.image)

        table.insert(self.tilesets, ts)
    end
end

function Level:createQuads(ts, image)
    local quads = {}

    local mx = ts.imagewidth - ts.margin - ts.tilewidth
    local my = ts.imageheight - ts.margin - ts.tileheight
    local dx = ts.tilewidth + ts.spacing
    local dy = ts.tileheight + ts.spacing

    for y = ts.margin, my, dy do
        for x = ts.margin, mx, dx do
            local quad = love.graphics.newQuad(x, y, ts.tilewidth, ts.tileheight, ts.imagewidth, ts.imageheight)

            table.insert(quads, quad)
        end
    end
    print()

    return quads
end

function Level:loadLayers()
    self.tilelayers = {}
    self.objects = {}

    for _,layer in ipairs(self.data.layers) do
        if layer.type == "tilelayer" then
            self:loadTilelayer(layer)
        elseif layer.type == "objectgroup" then
            self:loadObjectgroup(layer)
        end
    end
end

function Level:loadTilelayer(layer)
    if layer.opacity == 0 or not layer.visible then return end

    local canvas = love.graphics.newCanvas(self.data.width * self.data.tilewidth, self.data.height * self.data.tileheight)

    love.graphics.setCanvas(canvas)

    for i,tid in ipairs(layer.data) do
        if tid > 0 then
            local quad = self.tilesets[1].quads[tid]

            local r = math.floor((i - 1) / layer.width)
            local c = (i - 1) % layer.width

            local x = c * self.data.tilewidth
            local y = r * self.data.tileheight

            love.graphics.draw(self.tilesets[1].image, quad, x, y)
        end
    end

    love.graphics.setCanvas()

    table.insert(self.tilelayers, canvas)
end

function Level:loadObjectgroup(group)
    if not group.visible or group.opacity == 0 then return end

    for _,object in ipairs(group.objects) do
        local o = {}
        o.body = love.physics.newBody(self.world, object.x + self.data.tilewidth / 2, object.y - self.data.tileheight / 2, "static")
        o.shape = love.physics.newRectangleShape(self.data.tilewidth, self.data.tileheight)
        o.fixture = love.physics.newFixture(o.body, o.shape)
        o.name = object.name
        o.type = object.type
        o.gid = object.gid

        if o.name == "Terminal" or o.name == "Exit" then
            o.fixture:setSensor(true)
        end

        table.insert(self.objects, o)
    end
end

function Level:draw()
    self:drawTilelayers()
    self:drawObjects()
end

function Level:drawTilelayers()
    for _,layer in ipairs(self.tilelayers) do
        love.graphics.draw(layer)
    end
end

function Level:drawObjects()
    for _,object in ipairs(self.objects) do
        local x, y = object.fixture:getBoundingBox()
        x, y = math.ceil(x), math.ceil(y)

        love.graphics.draw(self.tilesets[1].image, self.tilesets[1].quads[object.gid], x, y)
    end
end

return Level
