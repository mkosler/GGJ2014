local Barrier = require("src.game.interactives.barrier")
local Button = require("src.game.interactives.button")
local Class = require("lib.hump.class")
local Exit = require("src.game.interactives.exit")
local Interactive = require("src.game.interactives.interactive")
local Terminal = require("src.game.interactives.terminal")
local Wall = require("src.game.interactives.wall")

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

    return quads
end

function Level:loadLayers()
    self.tilelayers = {}
    self.interactives = {}
    self.collisions = {}

    for _,layer in ipairs(self.data.layers) do
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
        local interactive = nil

        if object.name == "Barrier" then
            interactive = Barrier(self.world, self.tilesets[1].image, self.tilesets[1].quads[object.gid], object)
        elseif object.name == "Terminal" then
            interactive = Terminal(self.world, self.tilesets[1].image, self.tilesets[1].quads[object.gid], object)
        elseif object.name == "Exit" then
            interactive = Exit(self.world, self.tilesets[1].image, self.tilesets[1].quads[object.gid], object)
        elseif object.name == "Button" then
            interactive = Button(self.world, self.tilesets[1].image, self.tilesets[1].quads[object.gid], object, self.tilesets[1].quads[object.gid + 1])
        elseif object.name == "Wall" then
            interactive = Wall(self.world, self.tilesets[1].image, self.tilesets[1].quads[object.gid], object)
        elseif object.name == "Entrance" then
            self.entrance = { x = object.x, y = object.y }
        end

        table.insert(self.interactives, interactive)
    end

    for _,interactive in ipairs(self.interactives) do
        if interactive.name == "Wall" then
            for _,button in ipairs(self.interactives) do
                if interactive.type == button.type then
                    interactive:setButton(button)
                end
            end
        end
    end
end

function Level:getEntrance()
    if self.entrance then return self.entrance.x, self.entrance.y end
end

function Level:setMood(mood)
    for i,interactive in ipairs(self.interactives) do
        if interactive.name == "Barrier" then
            interactive.body:setActive(interactive.type ~= mood)
            interactive.visible = false
        end
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

        table.insert(self.collisions, o)
    end
end

function Level:update(dt)
    for i,interactive in ipairs(self.interactives) do
        if interactive.update then interactive:update(dt) end
    end
end

function Level:draw()
    self:drawTilelayers()
    self:drawInteractives()

    --self:drawDoors()
end

function Level:drawTilelayers()
    for _,layer in ipairs(self.tilelayers) do
        love.graphics.draw(layer)
    end
end

function Level:drawInteractives()
    for _,interactive in ipairs(self.interactives) do
        interactive:draw()
    end
end

function Level:drawDoors()
    local color = { love.graphics.getColor() }

    love.graphics.setColor(255, 0, 0)

    for i,interactive in ipairs(self.interactives) do
        if interactive.name == "Barrier" or interactive.name == "Wall" then
            love.graphics.polygon("line", interactive.body:getWorldPoints(interactive.shape:getPoints()))
        end
    end

    love.graphics.setColor(color)
end

return Level
