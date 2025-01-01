---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_wetland = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_wetland.init()

    return {
        description = "Aotearoa wetland biomes",
        depends = {
            "clay_gumland",
            "dirt_mud_antipodean",
            "dirt_peat_antipodean",
            "dirt_peat_forest",
            "dirt_peat_restiad",
            "liquid_water_river",
            "sand_river",
            "sand_silt_antipodean",
            "stone_sandstone_grey",
            "stone_sandstone_pale",
        },
    }

end

function unilib.pkg.biome_aotearoa_wetland.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "kahikatea_swamp" biome
        name = "aotearoa_wetland_kahikatea_swamp",
        description = unilib.utils.brackets(S("Wetland biome"), "aotearoa"),
        node_top = "unilib:dirt_peat_forest",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 6,
        node_stone = "unilib:stone_sandstone_grey",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 1,
        y_max = 27,
        y_min = 5,
        heat_point = 30,
        humidity_point = 100,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "raupo_swamp" biome
        name = "aotearoa_wetland_raupo_swamp",
        description = unilib.utils.brackets(S("Raupo swamp biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_wet",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:dirt_mud_antipodean_dry",
        depth_riverbed = 1,
        y_max = 40,
        y_min = 5,
        heat_point = 50,
        humidity_point = 145,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "gumland" biome
        name = "aotearoa_wetland_gumland",
        description = unilib.utils.brackets(S("Gumland biome"), "aotearoa"),
        node_top = "unilib:clay_gumland_topsoil",
        depth_top = 1,
        node_filler = "unilib:clay_gumland_hardpan",
        depth_filler = 4,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_silt_antipodean",
        depth_riverbed = 3,
        y_max = 80,
        y_min = 12,
        heat_point = 110,
        humidity_point = 3,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "fen" biome
        name = "aotearoa_wetland_fen",
        description = unilib.utils.brackets(S("Fen biome"), "aotearoa"),
        node_top = "unilib:dirt_peat_restiad",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:dirt_mud_antipodean_dry",
        depth_riverbed = 1,
        y_max = 80,
        y_min = 12,
        heat_point = 90,
        humidity_point = 110,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "peat_bog" biome
        name = "aotearoa_wetland_peat_bog",
        description = unilib.utils.brackets(S("Peat bog biome"), "aotearoa"),
        node_top = "unilib:dirt_peat_restiad",
        depth_top = 1,
        node_filler = "unilib:dirt_peat_antipodean",
        depth_filler = 15,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:dirt_peat_antipodean",
        depth_riverbed = 4,
        y_max = 40,
        y_min = 12,
        heat_point = 50,
        humidity_point = 120,
    })

end
