---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_shore = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_shore.init()

    return {
        description = "Aotearoa shore biomes",
        depends = {
            "dirt_mud_antipodean",
            "gravel_ordinary",
            "gravel_ordinary_with_algae",
            "liquid_water_river",
            "sand_ironsand",
            "sand_ordinary",
            "sand_river",
            "sand_seashells",
            "stone_andesite_antipodean",
            "stone_basalt_black",
            "stone_granite_antipodean",
            "stone_sandstone_grey",
            "stone_sandstone_pale",
            "stone_scoria",
        },
    }

end

function unilib.pkg.biome_aotearoa_shore.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "sandy_beach" biome
        name = "aotearoa_shore_sandy_beach",
        description = unilib.utils.brackets(S("Sandy shore biome"), "aotearoa"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 2,
        y_max = 3,
        y_min = -23,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "shelly_beach" biome
        name = "aotearoa_shore_shelly_beach",
        description = unilib.utils.brackets(S("Shelly beach biome"), "aotearoa"),
        node_top = "unilib:sand_seashells",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 1,
        y_max = 3,
        y_min = -5,
        heat_point = 80,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "gravel_beach" biome
        name = "aotearoa_shore_gravel_beach",
        description = unilib.utils.brackets(S("Gravel beach biome"), "aotearoa"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 3,
        y_min = -23,
        heat_point = 30,
        humidity_point = 10,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "subantarctic_shore" biome
        name = "aotearoa_shore_subantarctic",
        description = unilib.utils.brackets(S("Subantarctic shore biome"), "aotearoa"),
        node_filler = "unilib:stone_andesite_antipodean",
        depth_filler = 4,
        node_stone = "unilib:stone_granite_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 3,
        y_min = -12,
        heat_point = 0,
        humidity_point = 100,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "volcanic_isle_shore" biome
        name = "aotearoa_shore_volcanic_isle",
        description = unilib.utils.brackets(S("Volcanic isle biome"), "aotearoa"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_andesite_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 3,
        y_min = -23,
        heat_point = 120,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "volcanic_field" biome
        name = "aotearoa_shore_volcanic_field",
        description = unilib.utils.brackets(S("Volcanic field biome"), "aotearoa"),
        node_top = "unilib:stone_scoria",
        depth_top = 1,
        node_filler = "unilib:stone_scoria",
        depth_filler = 8,
        node_stone = "unilib:stone_basalt_black",
        node_river_water = "unilib:stone_basalt_black",
        node_riverbed = "unilib:stone_basalt_black",
        depth_riverbed = 5,
        y_max = 40,
        y_min = -23,
        heat_point = 120,
        humidity_point = 48,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "iron_sand_beach" biome
        name = "aotearoa_shore_ironsand_beach",
        description = unilib.utils.brackets(S("Iron sand beach biome"), "aotearoa"),
        node_top = "unilib:sand_ironsand",
        depth_top = 3,
        node_filler = "unilib:sand_ironsand",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_grey",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 1,
        y_max = 3,
        y_min = -23,
        heat_point = 50,
        humidity_point = 85,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "northern_estuary" biome
        name = "aotearoa_shore_northern_estuary",
        description = unilib.utils.brackets(S("Northern estuary biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_wet",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 10,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:dirt_mud_antipodean_dry",
        depth_riverbed = 5,
        y_max = 3,
        y_min = -23,
        heat_point = 85,
        humidity_point = 100,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "southern_estuary" biome
        name = "aotearoa_shore_southern_estuary",
        description = unilib.utils.brackets(S("Southern estuary biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 5,
        node_stone = "unilib:stone_sandstone_grey",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:dirt_mud_antipodean_dry",
        depth_riverbed = 1,
        y_max = 3,
        y_min = -23,
        heat_point = 30,
        humidity_point = 100,
    })

end
