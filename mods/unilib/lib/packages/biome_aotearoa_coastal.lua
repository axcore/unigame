---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_coastal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_coastal.init()

    return {
        description = "Aotearoa coastal forest biomes",
        depends = {
            "clay_ordinary",
            "dirt_ordinary",
            "gravel_ordinary_with_algae",
            "liquid_water_river",
            "sand_river",
            "sand_silt_antipodean",
            "stone_sandstone_grey",
            "stone_sandstone_pale",
        },
        optional = "dirt_custom_antipodean",
    }

end

function unilib.pkg.biome_aotearoa_coastal.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "pohutukawa_forest" biome
        name = "aotearoa_coastal_pohutukawa_forest",
        description = unilib.utils.brackets(S("Pohutukawa forest biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_rainforest",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_river",
        depth_riverbed = 1,
        y_max = 14,
        y_min = 3,
        heat_point = 90,
        humidity_point = 50,
    })

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf"

    else

        node_filler = "unilib:dirt_antipodean"
        -- Produces unilib:dirt_antipodean_with_turf_coastal_scrub
        node_top = unilib.pkg.dirt_custom_antipodean.generate_antipodean_dirt(
            "coastal_scrub", S("Coastal Scrub Turf"), "#538003:96"
        )

    end

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "coastal_scrub" biome
        name = "aotearoa_coastal_scrub",
        description = unilib.utils.brackets(S("Coastal scrub biome"), "aotearoa"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 4,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 20,
        y_min = 3,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "muttonbird_scrub" biome
        name = "aotearoa_coastal_muttonbird_scrub",
        description = unilib.utils.brackets(S("Muttonbird scrub biome"), "aotearoa"),
        node_top = "unilib:dirt_ordinary_with_litter_rainforest",
        depth_top = 1,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_sandstone_grey",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 14,
        y_min = 3,
        heat_point = 20,
        humidity_point = 70,
    })

    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_top = "unilib:dirt_ordinary_with_turf_dry"

    else

        -- Produces unilib:dirt_ordinary_with_turf_coastal_tussock
        node_top = unilib.pkg.dirt_custom_antipodean.generate_ordinary_dirt(
            "coastal_tussock", S("Coastal Tussock Turf"), "#FF7A00:96"
        )

    end

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "coastal_tussock" biome
        name = "aotearoa_coastal_tussock",
        description = unilib.utils.brackets(S("Coastal tussock biome"), "aotearoa"),
        node_top = node_top,
        depth_top = 1,
        node_filler = "unilib:sand_silt_antipodean",
        depth_filler = 4,
        node_stone = "unilib:stone_sandstone_pale",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 14,
        y_min = 3,
        heat_point = 15,
        humidity_point = 5,
    })

end
