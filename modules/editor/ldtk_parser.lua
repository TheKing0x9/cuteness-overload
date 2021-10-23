local json = require "modules.internals.json"

local M = {}

function M.parse(root, text)
  -- print(filename)
  -- local file = io.open(filename, "r")
  -- local text = file:read("*a")

  local data = json.decode(text)
  local tilesize = data.defaultGridSize

  local function calc_tileset_pos(x, y)
    return 32 * (y / tilesize) + (x / tilesize)
  end

  for _, v in pairs(data.levels) do
    -- create the file
    local tileset = io.open("." .. root  .. v.identifier .. ".tilemap", "w")
    -- write the location of the tileset
    tileset:write("tile_set: \"/assets/tilesources/main.tilesource\"\n")

    for _, v in pairs(v.layerInstances) do
      tileset:write("layers {\n")

      -- write defaults
      tileset:write("id: \"" .. v.__identifier .. "\"\n")
      tileset:write("z: 0.0\n")
      tileset:write("is_visible : 1\n")

      local w, h = v.__cWid, v.__cHei
      -- write cells
      for _,v in pairs(v.gridTiles) do
        tileset:write("cell {\n")
        tileset:write("x: " .. string.format("%d", v.px[1] / tilesize) .. "\n")
        tileset:write("y: " .. string.format("%d", h - v.px[2] / tilesize) .. "\n")
        tileset:write("tile: " .. string.format("%d", calc_tileset_pos(v.src[1], v.src[2])) .. "\n")
        tileset:write("h_flip: 0\nv_flip: 0\n")
        tileset:write("}\n")
      end

      tileset:write("}\n")
    end

    tileset:write([[material: "/builtins/materials/tile_map.material"
  blend_mode: BLEND_MODE_ALPHA]])

    tileset:close()
  end
end

return M
