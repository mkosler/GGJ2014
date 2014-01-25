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
        1, 0, 0, 0, 0, 1, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 4, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      name = "Objects",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "Terminal",
          type = "happy",
          shape = "rectangle",
          x = 32,
          y = 128,
          width = 0,
          height = 0,
          gid = 9,
          visible = true,
          properties = {}
        },
        {
          name = "Door",
          type = "happy",
          shape = "rectangle",
          x = 80,
          y = 144,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Door",
          type = "happy",
          shape = "rectangle",
          x = 80,
          y = 128,
          width = 0,
          height = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          name = "Door",
          type = "happy",
          shape = "rectangle",
          x = 80,
          y = 112,
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
          x = 32,
          y = 80,
          width = 0,
          height = 0,
          gid = 10,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
