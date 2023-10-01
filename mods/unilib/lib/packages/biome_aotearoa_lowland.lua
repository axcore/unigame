---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_lowland = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_lowland.init()

    return {
        description = "Aotearoa lowland biomes",
        depends = {
            "clay_ordinary",
            "dirt_antipodean",
            "gravel_ordinary",
            "gravel_ordinary_with_algae",
            "liquid_water_river",
            "snow_ordinary",
            "stone_gneiss_antipodean",
            "stone_greywacke_dark",
            "stone_sandstone_grey",
            "stone_sandstone_pale",
        },
    }

end

function unilib.pkg.biome_aotearoa_lowland.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "kauri_forest" biome
        name = "aotearoa_lowland_kauri_forest",
        description = unilib.brackets(S("Kauri forest biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_dry",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 12,
        heat_point = 90,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "northern_podocarp_forest" biome
        name = "aotearoa_lowland_northern_podocarp_forest",
        description = unilib.brackets(S("Northern podocarp forest biome"), "aotearoa"),
        node_top = "unilib:dirt_antipodean_dark_with_litter_wet",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 40,
        y_min = 12,
        heat_point = 70,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "tawa_forest" biome
        name = "aotearoa_lowland_tawa_forest",
        description = unilib.brackets(S("Tawa biome"), "aotearoa"),
        node_top = "unilib:dirt_antipodean_dark_with_litter_wet",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 12,
        heat_point = 70,
        humidity_point = 65,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "maire_forest" biome
        name = "aotearoa_lowland_maire_forest",
        description = unilib.brackets(S("Maire biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_dry",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 12,
        heat_point = 70,
        humidity_point = 35,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "southern_podocarp_forest" biome
        name = "aotearoa_lowland_southern_podocarp_forest",
        description = unilib.brackets(S("Southern podocarp biome"), "aotearoa"),
        node_top = "unilib:dirt_antipodean_dark_with_litter_wet",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_grey",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 40,
        y_min = 12,
        heat_point = 30,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "hinau_forest" biome
        name = "aotearoa_lowland_hinau_forest",
        description = unilib.brackets(S("Hinau biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_dry",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_greywacke_dark",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 12,
        heat_point = 30,
        humidity_point = 65,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "beech_forest" biome
        name = "aotearoa_lowland_beech_forest",
        description = unilib.brackets(S("Beech biome"), "aotearoa"),
        node_top = "unilib:dirt_antipodean_dark_with_litter_beech",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_greywacke_dark",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 12,
        heat_point = 30,
        humidity_point = 35,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "fiordland_forest" biome
        name = "aotearoa_lowland_fiordland_forest",
        description = unilib.brackets(S("Fiordland forest biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:dirt_antipodean_dark_with_litter_beech",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_gneiss_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 12,
        heat_point = 0,
        humidity_point = 90,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "kamahi_forest" biome
        name = "aotearoa_lowland_kamahi_forest",
        description = unilib.brackets(S("Kamahi forest biome"), "aotearoa"),
        node_top = "unilib:dirt_antipodean_with_moss",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_greywacke_dark",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 2,
        y_max = 80,
        y_min = 40,
        heat_point = 35,
        humidity_point = 100,
    })

end
