---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_dunes = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_dunes.init()

    return {
        description = "Aotearoa dunes biomes",
        depends = {
            "dirt_antipodean",
            "dirt_mud_antipodean",
            "gravel_ordinary",
            "gravel_ordinary_with_algae",
            "liquid_water_river",
            "sand_ironsand",
            "sand_ordinary",
            "sand_river",
            "sand_volcanic",
            "snow_ordinary",
            "stone_andesite_antipodean",
            "stone_granite_antipodean",
            "stone_sandstone_grey",
            "stone_sandstone_pale",
        },
    }

end

function unilib.pkg.biome_aotearoa_dunes.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "pohutukawa_dunes" biome
        name = "aotearoa_dunes_pohutukawa",
        description = unilib.brackets(S("Pohutukawa dunes biome"), "aotearoa"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 2,
        y_max = 5,
        y_min = 1,
        heat_point = 90,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "sand_dunes" biome
        name = "aotearoa_dunes_sand",
        description = unilib.brackets(S("Sand dunes biome"), "aotearoa"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 2,
        y_max = 5,
        y_min = 1,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "iron_sand_dunes" biome
        name = "aotearoa_dunes_ironsand",
        description = unilib.brackets(S("Iron sand dunes biome"), "aotearoa"),
        node_top = "unilib:sand_ironsand",
        depth_top = 3,
        node_filler = "unilib:sand_ironsand",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_grey",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 2,
        y_max = 5,
        y_min = 1,
        heat_point = 50,
        humidity_point = 85,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "salt_marsh" biome
        name = "aotearoa_dunes_salt_marsh",
        description = unilib.brackets(S("Salt marsh biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:dirt_mud_antipodean_dry",
        depth_riverbed = 2,
        y_max = 5,
        y_min = 1,
        heat_point = 50,
        humidity_point = 95,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "gravel_dunes" biome
        name = "aotearoa_dunes_gravel",
        description = unilib.brackets(S("Gravel dunes biome"), "aotearoa"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 5,
        y_min = 1,
        heat_point = 30,
        humidity_point = 10,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "subantarctic_coast" biome
        name = "aotearoa_dunes_subantarctic_coast",
        description = unilib.brackets(S("Subantarctic coast biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:dirt_antipodean_with_moss",
        depth_top = 1,
        node_filler = "unilib:stone_andesite_antipodean",
        depth_filler = 4,
        node_stone = "unilib:stone_granite_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 14,
        y_min = 1,
        heat_point = 0,
        humidity_point = 100,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "white_island" biome
        name = "aotearoa_dunes_white_island",
        description = unilib.brackets(S("White island biome"), "aotearoa"),
        node_top = "unilib:sand_volcanic",
        depth_top = 1,
        node_filler = "unilib:sand_volcanic",
        depth_filler = 5,
        node_stone = "unilib:stone_andesite_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 40,
        y_min = 1,
        heat_point = 120,
        humidity_point = 0,
    })

end
