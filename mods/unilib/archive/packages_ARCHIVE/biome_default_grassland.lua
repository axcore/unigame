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
    name = "grassland",
    node_top = "default:dirt_with_grass",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 1,
    node_riverbed = "default:sand",
    depth_riverbed = 2,
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = 31000,
    y_min = 6,
    heat_point = 50,
    humidity_point = 35,
})

minetest.register_biome({
    name = "grassland_dunes",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 2,
    node_riverbed = "default:sand",
    depth_riverbed = 2,
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    vertical_blend = 1,
    y_max = 5,
    y_min = 4,
    heat_point = 50,
    humidity_point = 35,
})

minetest.register_biome({
    name = "grassland_ocean",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 3,
    node_riverbed = "default:sand",
    depth_riverbed = 2,
    node_cave_liquid = "default:water_source",
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = 3,
    y_min = -255,
    heat_point = 50,
    humidity_point = 35,
})

minetest.register_biome({
    name = "grassland_under",
    node_cave_liquid = {"default:water_source", "default:lava_source"},
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = -256,
    y_min = -31000,
    heat_point = 50,
    humidity_point = 35,
})
]]--
