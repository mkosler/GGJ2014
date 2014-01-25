return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 10,
  height = 10,
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
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        6, 7, 1, 1, 1, 1, 1, 1, 1, 1,
        11, 12, 1, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 10, 0, 0, 1, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 4, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 8, 0, 0, 1, 1,
        1, 0, 9, 0, 0, 8, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 8, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1
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
          width = 48,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 0,
          width = 112,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 16,
          width = 16,
          height = 144,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 96,
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
          y = 32,
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
          y = 48,
          width = 16,
          height = 112,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 144,
          width = 128,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 64,
          width = 16,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 80,
          width = 64,
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
          x = 80,
          y = 96,
          width = 16,
          height = 48,
          visible = true,
          properties = {}
        },
        {
          name = "Terminal",
          type = "happy",
          shape = "rectangle",
          x = 32,
          y = 112,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        },
        {
          name = "Exit",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 64,
          width = 16,
          height = 16,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
