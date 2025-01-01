---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_tundra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_tundra.init()

    return {
        description = "Tundra biomes",
        depends = {
            "dirt_permafrost_ordinary",
            "gravel_ordinary",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "snow_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_tundra.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra_highland" biome
        name = "ethereal_tundra_highland",
        description = unilib.utils.brackets(S("Highland tundra biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary",
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 180,
        y_min = 47,
        vertical_blend = 1,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra" biome
        name = "ethereal_tundra",
        description = unilib.utils.brackets(S("Tundra biome"), "ethereal"),
        node_top = "unilib:dirt_permafrost_ordinary_with_litter_stone",
        depth_top = 1,
        node_filler = "unilib:dirt_permafrost_ordinary",
        depth_filler = 1,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 46,
        y_min = 2,
        vertical_blend = 4,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra_beach" biome
        name = "ethereal_tundra_beach",
        description = unilib.utils.brackets(S("Tundra beach biome"), "ethereal"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 1,
        y_min = -3,
        vertical_blend = 1,
        heat_point = 0,
        humidity_point = 40
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra_ocean" biome
        name = "ethereal_tundra_ocean",
        description = unilib.utils.brackets(S("Tundra ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -4,
        y_min = -112,
        vertical_blend = 1,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra_under" biome
        name = "ethereal_tundra_under",
        description = unilib.utils.brackets(S("Tundra underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.constant.y_min,
        heat_point = 0,
        humidity_point = 40,
    })

end
