---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_ocean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_ocean.init()

    return {
        description = "Aotearoa ocean biomes",
        depends = {
            "dirt_mud_antipodean",
            "gravel_ordinary",
            "sand_ironsand",
            "sand_ordinary",
            "stone_andesite_antipodean",
            "stone_gneiss_antipodean",
            "stone_granite_antipodean",
            "stone_greywacke_dark",
            "stone_sandstone_grey",
            "stone_sandstone_pale",
            "stone_schist_antipodean",
        },
    }

end

function unilib.pkg.biome_aotearoa_ocean.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "kermadec_ocean" biome
        name = "aotearoa_ocean_kermadec",
        description = unilib.brackets(S("Kermadec ocean biome"), "aotearoa"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:stone_andesite_antipodean",
        depth_filler = 2,
        node_stone = "unilib:stone_andesite_antipodean",
        y_max = -21,
        y_min = -402,
        heat_point = 120,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "north_eastern_ocean" biome
        name = "aotearoa_ocean_north_eastern",
        description = unilib.brackets(S("Northeastern ocean biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_wet",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 6,
        node_stone = "unilib:stone_sandstone_pale",
        y_max = -21,
        y_min = -402,
        heat_point = 90,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "west_coast_north_ocean" biome
        name = "aotearoa_ocean_west_coast_north",
        description = unilib.brackets(S("West coast north ocean biome"), "aotearoa"),
        node_top = "unilib:sand_ironsand",
        depth_top = 1,
        node_filler = "unilib:sand_ironsand",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_grey",
        y_max = -21,
        y_min = -402,
        heat_point = 50,
        humidity_point = 85,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "east_coast_north_ocean" biome
        name = "aotearoa_ocean_east_coast_north",
        description = unilib.brackets(S("East coast north ocean biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_wet",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 4,
        node_stone = "unilib:stone_sandstone_pale",
        y_max = -21,
        y_min = -402,
        heat_point = 50,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "north_cook_straight" biome
        name = "aotearoa_ocean_north_cook_strait",
        description = unilib.brackets(S("North cook strait biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 3,
        node_stone = "unilib:stone_greywacke_dark",
        y_max = -21,
        y_min = -402,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "south_cook_straight" biome
        name = "aotearoa_ocean_south_cook_strait",
        description = unilib.brackets(S("South cook strait biome"), "aotearoa"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_schist_antipodean",
        y_max = -21,
        y_min = -402,
        heat_point = 30,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "west_coast_south_ocean" biome
        name = "aotearoa_ocean_west_coast_south",
        description = unilib.brackets(S("West coast south ocean biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_grey",
        y_max = -21,
        y_min = -402,
        heat_point = 30,
        humidity_point = 100,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "east_coast_south_ocean" biome
        name = "aotearoa_ocean_east_coast_south",
        description = unilib.brackets(S("East coast south ocean biome"), "aotearoa"),
        node_top = "unilib:dirt_mud_antipodean_wet",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 6,
        node_stone = "unilib:stone_greywacke_dark",
        y_max = -21,
        y_min = -402,
        heat_point = 15,
        humidity_point = 5,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "fiordland_ocean" biome
        description = unilib.brackets(S("Fiordland ocean biome"), "aotearoa"),
        name = "aotearoa_ocean_fiordland",
        node_top = "unilib:dirt_mud_antipodean_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_mud_antipodean_dry",
        depth_filler = 2,
        node_stone = "unilib:stone_gneiss_antipodean",
        y_max = -21,
        y_min = -402,
        heat_point = 0,
        humidity_point = 90,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "southern_ocean" biome
        name = "aotearoa_ocean_southern",
        description = unilib.brackets(S("Southern ocean biome"), "aotearoa"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_schist_antipodean",
        y_max = -21,
        y_min = -402,
        heat_point = 20,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "subantarctic_ocean" biome
        name = "aotearoa_ocean_subantarctic",
        description = unilib.brackets(S("Subantarctic ocean biome"), "aotearoa"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_granite_antipodean",
        y_max = -21,
        y_min = -402,
        heat_point = 0,
        humidity_point = 100,
    })

end
