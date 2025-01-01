---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_desert_cold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_desert_cold.init()

    return {
        description = "Cold desert biomes",
        depends = {
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "sand_silver",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_desert_cold.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "cold_desert" biome
        name = "ethereal_desert_cold",
        description = unilib.utils.brackets(S("Cold desert biome"), "ethereal"),
        node_top = "unilib:sand_silver",
        depth_top = 1,
        node_filler = "unilib:sand_silver",
        depth_filler = 1,
        node_riverbed = "unilib:sand_silver",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 100,
        y_min = 4,
        vertical_blend = 1,
        heat_point = 20,
        humidity_point = 85,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "cold_desert_ocean" biome
        name = "ethereal_desert_cold_ocean",
        description = unilib.utils.brackets(S("Cold desert ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_cave_liquid = "unilib:liquid_water_ordinary_source",
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 3,
        y_min = -255,
        vertical_blend = 1,
        heat_point = 20,
        humidity_point = 85,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "cold_desert_under" biome
        name = "ethereal_desert_cold_under",
        description = unilib.utils.brackets(S("Cold desert underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_lava_ordinary_source",
            "unilib:liquid_water_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = -31000,
        heat_point = 20,
        humidity_point = 85,
    })

end
