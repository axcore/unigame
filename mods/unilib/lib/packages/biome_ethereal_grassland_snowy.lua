---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_grassland_snowy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_grassland_snowy.init()

    return {
        description = "Snowy grassland biomes",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_cold",
            "sand_ordinary",
            "snow_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_grassland_snowy.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "snowy_grassland" biome
        name = "ethereal_grassland_snowy",
        description = unilib.utils.brackets(S("Snowy grassland biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_cold",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 30,
        y_min = 3,
        vertical_blend = 1,
        heat_point = 15,
        humidity_point = 58,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "snowy_grassland_ocean" biome
        name = "ethereal_grassland_snowy_ocean",
        description = unilib.utils.brackets(S("Snowy grassland ocean biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 2,
        y_min = -192,
        vertical_blend = 1,
        heat_point = 15,
        humidity_point = 58,
    })

end
