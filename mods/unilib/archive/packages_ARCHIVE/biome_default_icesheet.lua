---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_biome({
    name = "icesheet",
    node_dust = "default:snowblock",
    node_top = "default:snowblock",
    depth_top = 1,
    node_filler = "default:snowblock",
    depth_filler = 3,
    node_stone = "default:cave_ice",
    node_water_top = "default:ice",
    depth_water_top = 10,
    node_river_water = "default:ice",
    node_riverbed = "default:gravel",
    depth_riverbed = 2,
    node_dungeon = "default:ice",
    node_dungeon_stair = "stairs:stair_ice",
    y_max = 31000,
    y_min = -8,
    heat_point = 0,
    humidity_point = 73,
})

minetest.register_biome({
    name = "icesheet_ocean",
    node_dust = "default:snowblock",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 3,
    node_water_top = "default:ice",
    depth_water_top = 10,
    node_cave_liquid = "default:water_source",
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = -9,
    y_min = -255,
    heat_point = 0,
    humidity_point = 73,
})

minetest.register_biome({
    name = "icesheet_under",
    node_cave_liquid = {"default:water_source", "default:lava_source"},
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = -256,
    y_min = -31000,
    heat_point = 0,
    humidity_point = 73,
})
]]--
