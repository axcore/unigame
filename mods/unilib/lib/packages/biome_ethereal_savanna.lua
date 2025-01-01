---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_savanna = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_savanna.init()

    return {
        description = "Savanna biomes",
        depends = {
            "dirt_dry",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_savanna.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "savanna" biome
        name = "ethereal_savanna",
        description = unilib.utils.brackets(S("Savanna biome"), "ethereal"),
        node_top = "unilib:dirt_dry_with_turf_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_dry",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 50,
        y_min = 3,
        vertical_blend = 1,
        heat_point = 89,
        humidity_point = 42,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "savanna_ocean" biome
        name = "ethereal_savanna_ocean",
        description = unilib.utils.brackets(S("Savanna ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 2,
        y_min = -192,
        heat_point = 89,
        humidity_point = 42,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "savanna_under" biome
        name = "ethereal_savanna_under",
        description = unilib.utils.brackets(S("Savanna underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.constant.y_min,
        heat_point = 89,
        humidity_point = 42,
    })

end
