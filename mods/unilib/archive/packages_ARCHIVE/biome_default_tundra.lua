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
    name = "tundra_highland",
    node_dust = "default:snow",
    node_riverbed = "default:gravel",
    depth_riverbed = 2,
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = 31000,
    y_min = 47,
    heat_point = 0,
    humidity_point = 40,
})

minetest.register_biome({
    name = "tundra",
    node_top = "default:permafrost_with_stones",
    depth_top = 1,
    node_filler = "default:permafrost",
    depth_filler = 1,
    node_riverbed = "default:gravel",
    depth_riverbed = 2,
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    vertical_blend = 4,
    y_max = 46,
    y_min = 2,
    heat_point = 0,
    humidity_point = 40,
})

minetest.register_biome({
    name = "tundra_beach",
    node_top = "default:gravel",
    depth_top = 1,
    node_filler = "default:gravel",
    depth_filler = 2,
    node_riverbed = "default:gravel",
    depth_riverbed = 2,
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    vertical_blend = 1,
    y_max = 1,
    y_min = -3,
    heat_point = 0,
    humidity_point = 40,
})

minetest.register_biome({
    name = "tundra_ocean",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 3,
    node_riverbed = "default:gravel",
    depth_riverbed = 2,
    node_cave_liquid = "default:water_source",
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    vertical_blend = 1,
    y_max = -4,
    y_min = -255,
    heat_point = 0,
    humidity_point = 40,
})

minetest.register_biome({
    name = "tundra_under",
    node_cave_liquid = {"default:water_source", "default:lava_source"},
    node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
    node_dungeon_stair = "stairs:stair_cobble",
    y_max = -256,
    y_min = -31000,
    heat_point = 0,
    humidity_point = 40,
})
]]--
