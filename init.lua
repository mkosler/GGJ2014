return {
    FONTS = {
        [10] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 10),
        [12] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 12),
        [16] = love.graphics.newFont("assets/fonts/slkscrb.ttf", 16),
    },
    LEVELS = {
        {
            NAME = "Level 1",
            PATH = "assets.maps.level1",
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
                JUMP = { 0, -300 },
            },
        },
    },
    TERMINALS = {
        IMAGE = love.graphics.newImage("assets/images/textbox.png"),
        NEUTRAL = {
            "YOUR FUNCTIONS PERFORMING AT SATISFACTORY LEVELS",
            "FE 8F CC 24 A4 B9 C1 C7 70 00",
            "AFFIRMATIVE",
        },
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
