return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 20,
  height = 20,
  tilewidth = 16,
  tileheight = 16,
  properties = {},
  tilesets = {
    {
      name = "GGJ2014",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "assets/images/tilesheet.png",
      imagewidth = 80,
      imageheight = 48,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Platforms",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        6, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        11, 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
        1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 6, 7, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 11, 12, 1, 1, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      name = "Collisions",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 320,
          height = 48,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 176,
          width = 112,
          height = 144,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 176,
          width = 128,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 112,
          width = 48,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 112,
          width = 128,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 304,
          width = 160,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 288,
          width = 48,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 272,
          width = 32,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 208,
          width = 32,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 208,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 48,
          width = 16,
          height = 160,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 240,
          width = 16,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 208,
          width = 64,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 224,
          width = 32,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 256,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 240,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 128,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 48,
          width = 48,
          height = 48,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 48,
          width = 32,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 64,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 96,
          width = 32,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 304,
          y = 112,
          width = 16,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 48,
          width = 48,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 64,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "Interactives",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "Barrier",
          type = "happy",
          shape = "rectangle",
          x = 208,
          y = 176,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Barrier",
          type = "happy",
          shape = "rectangle",
          x = 208,
          y = 160,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Wall",
          type = "1",
          shape = "rectangle",
          x = 128,
          y = 160,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Wall",
          type = "1",
          shape = "rectangle",
          x = 128,
          y = 176,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Barrier",
          type = "neutral",
          shape = "rectangle",
          x = 128,
          y = 272,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Barrier",
          type = "neutral",
          shape = "rectangle",
          x = 128,
          y = 288,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Barrier",
          type = "neutral",
          shape = "rectangle",
          x = 128,
          y = 304,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Exit",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 304,
          width = 0,
          height = 0,
          gid = 10,
          visible = true,
          properties = {}
        },
        {
          name = "Terminal",
          type = "happy",
          shape = "rectangle",
          x = 272,
          y = 176,
          width = 0,
          height = 0,
          gid = 9,
          visible = true,
          properties = {}
        },
        {
          name = "Terminal",
          type = "sad",
          shape = "rectangle",
          x = 64,
          y = 176,
          width = 0,
          height = 0,
          gid = 9,
          visible = true,
          properties = {}
        },
        {
          name = "Button",
          type = "1",
          shape = "rectangle",
          x = 176,
          y = 304,
          width = 0,
          height = 0,
          gid = 13,
          visible = true,
          properties = {}
        },
        {
          name = "Barrier",
          type = "neutral",
          shape = "rectangle",
          x = 112,
          y = 96,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Barrier",
          type = "neutral",
          shape = "rectangle",
          x = 112,
          y = 112,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Entrance",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 96,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
