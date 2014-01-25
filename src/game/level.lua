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
    self.interactives = {}
    self.collisions = {}

    for _,layer in ipairs(self.data.layers) do
        print(layer.type)
        if layer.type == "tilelayer" then
            self:loadTilelayer(layer)
        elseif layer.type == "objectgroup" then
            if layer.name == "Interactives" then
                self:loadInteractives(layer)
            elseif layer.name == "Collisions" then
                self:loadCollisions(layer)
            end
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

function Level:loadInteractives(group)
    if not group.visible or group.opacity == 0 then return end

    for _,object in ipairs(group.objects) do
        local o = {}

        o.name = object.name
        o.type = object.type

        o.body = love.physics.newBody(self.world, object.x + object.width / 2, object.y + object.height / 2, "static")
        o.shape = love.physics.newRectangleShape(object.width, object.height)
        o.fixture = love.physics.newFixture(o.body, o.shape)

        if o.name ~= "Barrier" then
            o.fixture:setSensor(true)
        end

        table.insert(self.interactives, o)
    end
end

function Level:loadCollisions(group)
    if not group.visible or group.opacity == 0 then return end

    for _,object in ipairs(group.objects) do
        local o = {}

        o.name = object.name
        o.type = object.type

        o.body = love.physics.newBody(self.world, object.x + object.width / 2, object.y + object.height / 2, "static")
        o.shape = love.physics.newRectangleShape(object.width, object.height)
        o.fixture = love.physics.newFixture(o.body, o.shape)

        table.insert(self.interactives, o)
    end
end

function Level:draw()
    love.graphics.setColor(255, 255, 255)
    self:drawTilelayers()
    self:drawObjects()
end

function Level:drawTilelayers()
    for _,layer in ipairs(self.tilelayers) do
        love.graphics.draw(layer)
    end
end

function Level:drawObjects()
    love.graphics.setColor(255, 0, 0)

    for _,object in ipairs(self.interactives) do
        love.graphics.polygon("line", object.body:getWorldPoints(object.shape:getPoints()))
    end

    for _,object in ipairs(self.collisions) do
        love.graphics.polygon("line", object.body:getWorldPoints(object.shape:getPoints()))
    end
end

return Level
