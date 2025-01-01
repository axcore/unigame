---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_taiga = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_taiga.init()

    return {
        description = "Taiga biome",
        depends = {
            "dirt_ordinary",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "snow_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_taiga.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "taiga" biome
        name = "ethereal_taiga",
        description = unilib.utils.brackets(S("Taiga biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_cover_snow",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 140,
        y_min = 4,
        vertical_blend = 1,
        heat_point = 25,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "taiga_ocean" biome
        name = "ethereal_taiga_ocean",
        description = unilib.utils.brackets(S("Taiga ocean biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary",
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
        heat_point = 25,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "taiga_under" biome
        name = "ethereal_taiga_under",
        description = unilib.utils.brackets(S("Taiga underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.constant.y_min,
        heat_point = 25,
        humidity_point = 70,
    })

end
