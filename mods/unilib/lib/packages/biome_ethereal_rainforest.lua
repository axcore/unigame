---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_rainforest = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_rainforest.init()

    return {
        description = "Rainforest biomes",
        depends = {
            "dirt_ordinary",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_rainforest.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "rainforest" (formerly "junglee") biome
        name = "ethereal_rainforest",
        description = unilib.utils.brackets(S("Rainforest biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_litter_rainforest",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 71,
        y_min = 1,
        vertical_blend = 1,
        heat_point = 86,
        humidity_point = 65,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "rainforest_ocean" (formerly "junglee_ocean") biome
        name = "ethereal_rainforest_ocean",
        description = unilib.utils.brackets(S("Rainforest ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 0,
        y_min = -192,
        heat_point = 86,
        humidity_point = 65,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "rainforest_under" biome
        name = "ethereal_rainforest_under",
        description = unilib.utils.brackets(S("Rainforest underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.constant.y_min,
        heat_point = 86,
        humidity_point = 65,
    })

end
