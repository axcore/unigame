---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_grayness = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_grayness.init()

    return {
        description = "Grayness [sic] biomes",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_grey",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "sand_silver",
            "stone_marble_blue",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_grayness.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "grayness" biome
        name = "ethereal_grayness",
        description = unilib.utils.brackets(S("Greyness biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_grey",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 41,
        y_min = 2,
        vertical_blend = 1,
        heat_point = 15,
        humidity_point = 30,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "grayness_ocean" biome
        name = "ethereal_grayness_ocean",
        description = unilib.utils.brackets(S("Greyness ocean biome"), "ethereal"),
        node_top = "unilib:sand_silver",
        depth_top = 2,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_marble_blue",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_marble_blue",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_marble_blue"),
        y_max = 2,
        y_min = -22,
        heat_point = 15,
        humidity_point = 30,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "grayness_under" biome
        name = "ethereal_grayness_under",
        description = unilib.utils.brackets(S("Greyness underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -23,
        y_min = unilib.constant.y_min,
        heat_point = 15,
        humidity_point = 30,
    })

end
