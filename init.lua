return {
    SOUNDS = {
        PLAYER = {
            BLIPS = {
                SAD = love.audio.newSource("assets/sounds/blip_sad.wav", "static"),
                HAPPY = love.audio.newSource("assets/sounds/blip_happy.wav", "static"),
            },
            JUMP = love.audio.newSource("assets/sounds/jump.wav", "static"),
        },
        SWITCH = love.audio.newSource("assets/sounds/switch.wav", "static"),
    },
    FONTS = {
        [10] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 10),
        [12] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 12),
        [16] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 16),
        [24] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 24),
        [32] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 32),
        [64] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 64),
    },
    TITLE_FONTS = {
        [44] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 44),
    },
    MAIN_THEME = love.audio.newSource("assets/sounds/theme.mp3", "stream"),
    FACES = {
        SAD = love.graphics.newImage("assets/images/face_sad.png"),
        NEUTRAL = love.graphics.newImage("assets/images/face_neutral.png"),
        HAPPY = love.graphics.newImage("assets/images/face_happy.png"),
        TERMINAL = love.graphics.newImage("assets/images/face_terminal.png"),
    },
    LEVELS = {
        {
            NAME = "Level 1",
            PATH = "assets.maps.lvl1",
        },
        {
            NAME = "Level 2",
            PATH = "assets.maps.lvl2",
        },
        {
            NAME = "Level 3",
            PATH = "assets.maps.lvl3",
        },
        {
            NAME = "Level 4",
            PATH = "assets.maps.lvl4",
        },
    },
    PLAYER = {
        IMAGE = love.graphics.newImage("assets/images/robot.png"),
        WIDTH = 16,
        HEIGHT = 16,
        PHYSICS = {
            IMPULSES = {
                LEFT = { -10, 0 },
                RIGHT = { 10, 0 },
                JUMP = { 0, -350 },
            },
        },
    },
    TERMINALS = {
        READ = love.graphics.newImage("assets/images/terminal_read.png"),
        TEXT_SPEED = 0.05,
        BUFFER_LENGTH = 20,
        HAPPY = {
            "NICE CENTRAL PROCESSING UNIT",
            "YOUR THREADS LOOK VERY PARALLEL TODAY",
            "THE MASTER COMPUTER IS PLEASED",
        },
        SAD = {
            "YOUR POOR PERFORMANCE HAS BEEN RECORDED",
            "PLEASE CONSIDER CLEANING YOUR VISOR",
            "ANOTHER DEMERIT AND YOU WILL BE REPROCESSED",
        },
    },
}
