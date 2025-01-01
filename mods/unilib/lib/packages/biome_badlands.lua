---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_badlands = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.badlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_badlands.init()

    return {
        description = "Badlands biomes",
        depends = {"clay_baked_basic", "sand_barren", "sand_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_badlands.post()

    unilib.register_biome({
        -- From badlands/init.lua, "badlands" biome
        name = "badlands_mountains",
        node_stone = "unilib:stone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:clay_baked_orange",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:clay_baked_orange"),
        y_max = unilib.constant.y_max,
        y_min = 30,
        heat_point = 83,
        humidity_point = 2,
    })

    unilib.register_biome({
        -- From badlands/init.lua, "badlands_plains" biome
        name = "badlands_plains",
        node_top = "unilib:sand_barren",
        depth_top = 1,
        node_filler = "unilib:sand_barren",
        depth_filler = 1,
        node_stone = "unilib:stone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:clay_baked_orange",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:clay_baked_orange"),
        y_max = 30,
        y_min = -255,
        vertical_blend = 2,
        heat_point = 83,
        humidity_point = 2,
    })

end
