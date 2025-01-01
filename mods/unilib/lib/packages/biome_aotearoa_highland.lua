---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_highland = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_highland.init()

    return {
        description = "Aotearoa highland biomes",
        depends = {
            "clay_ordinary",
            "dirt_antipodean",
            "dirt_ordinary",
            "dirt_peat_antipodean",
            "dirt_peat_restiad",
            "gravel_ordinary",
            "gravel_ordinary_with_algae",
            "liquid_water_river",
            "sand_silt_antipodean",
            "sand_volcanic",
            "snow_ordinary",
            "stone_andesite_antipodean",
            "stone_greywacke_dark",
            "stone_schist_antipodean",
        },
        optional = "dirt_custom_antipodean",
    }

end

function unilib.pkg.biome_aotearoa_highland.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "pahautea_forest" biome
        name = "aotearoa_highland_pahautea_forest",
        description = unilib.utils.brackets(S("Pahautea forest biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:dirt_antipodean_with_moss",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_andesite_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 120,
        y_min = 78,
        heat_point = 90,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "rangipo_desert" biome
        name = "aotearoa_highland_rangipo_desert",
        description = unilib.utils.brackets(S("Rangipo desert biome"), "aotearoa"),
        node_top = "unilib:sand_volcanic",
        depth_top = 6,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_andesite_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_volcanic",
        depth_riverbed = 3,
        y_max = 120,
        y_min = 90,
        heat_point = 90,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "mountain_beech_forest" biome
        name = "aotearoa_highland_mountain_beech_forest",
        description = unilib.utils.brackets(S("Mountain beech forest biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:dirt_antipodean_with_moss",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_schist_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 120,
        y_min = 78,
        heat_point = 40,
        humidity_point = 70,
    })

    local node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_top = "unilib:dirt_ordinary_with_turf_dry"

    else

        -- Produces unilib:dirt_ordinary_with_turf_highland_mountain_tussock
        node_top = unilib.pkg.dirt_custom_antipodean.generate_ordinary_dirt(
            "highland_mountain_tussock", S("Mountain Tussock Turf"), "#FF9500:96"
        )

    end

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "mountain_tussock" biome
        name = "aotearoa_highland_mountain_tussock",
        description = unilib.utils.brackets(S("Mountain tussock biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = node_top,
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_schist_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 121,
        y_min = 78,
        heat_point = 30,
        humidity_point = 30,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "alpine_peat_bog" biome
        name = "aotearoa_highland_peat_bog",
        description = unilib.utils.brackets(S("Alpine peat biome"), "aotearoa"),
        node_top = "unilib:dirt_peat_restiad",
        depth_top = 1,
        node_filler = "unilib:dirt_peat_antipodean",
        depth_filler = 6,
        node_stone = "unilib:stone_greywacke_dark",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:dirt_peat_antipodean",
        depth_riverbed = 3,
        y_max = 120,
        y_min = 78,
        heat_point = 50,
        humidity_point = 100,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "scree" biome
        name = "aotearoa_highland_scree",
        description = unilib.utils.brackets(S("Scree biome"), "aotearoa"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_silt_antipodean",
        depth_filler = 1,
        node_stone = "unilib:stone_greywacke_dark",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 140,
        y_min = 78,
        heat_point = 10,
        humidity_point = 0,
    })

end
