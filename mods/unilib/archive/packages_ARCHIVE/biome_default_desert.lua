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
    name = "desert",
    node_top = "default:desert_sand",
    depth_top = 1,
    node_filler = "default:desert_sand",
    depth_filler = 1,
    node_stone = "default:desert_stone",
    node_riverbed = "default:sand",
    depth_riverbed = 2,
    node_dungeon = "default:desert_stone",
    node_dungeon_stair = "stairs:stair_desert_stone",
    y_max = 31000,
    y_min = 4,
    heat_point = 92,
    humidity_point = 16,
})

minetest.register_biome({
    name = "desert_ocean",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 3,
    node_stone = "default:desert_stone",
    node_riverbed = "default:sand",
    depth_riverbed = 2,
    node_cave_liquid = "default:water_source",
    node_dungeon = "default:desert_stone",
    node_dungeon_stair = "stairs:stair_desert_stone",
    vertical_blend = 1,
    y_max = 3,
    y_min = -255,
    heat_point = 92,
    humidity_point = 16,
})

minetest.register_biome({
    name = "desert_under",
    node_cave_liquid = {"default:water_source", "default:lava_source"},
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = -256,
    y_min = -31000,
    heat_point = 92,
    humidity_point = 16,
})
]]--
