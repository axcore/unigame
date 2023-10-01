---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_scrubland = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_scrubland.init()

    return {
        description = "Aotearoa scrubland biomes",
        depends = {
            "clay_ordinary",
            "dirt_ordinary",
            "gravel_ordinary_with_algae",
            "liquid_water_river",
            "stone_schist_antipodean",
            "stone_sandstone_pale",
        },
    }

end

function unilib.pkg.biome_aotearoa_scrubland.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "broadleaf_scrub" biome
        name = "aotearoa_scrubland_broadleaf",
        description = unilib.brackets(S("Broafleaf scrub biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_rainforest",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 4,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 40,
        y_min = 16,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "geothermal_scrub" biome
        name = "aotearoa_scrubland_geothermal",
        description = unilib.brackets(S("Geothermal scrub biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_rainforest",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 4,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 27,
        y_min = 12,
        heat_point = 60,
        humidity_point = -10,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "manuka_scrub" biome
        name = "aotearoa_scrubland_manuka",
        description = unilib.brackets(S("Manuka scrub biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_rainforest",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 4,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 12,
        heat_point = 50,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "matagouri_scrub" biome
        name = "aotearoa_scrubland_matagouri",
        description = unilib.brackets(S("Matagouri scrub biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_turf_dry",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_schist_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 80,
        y_min = 12,
        heat_point = 15,
        humidity_point = 5,
    })

end
