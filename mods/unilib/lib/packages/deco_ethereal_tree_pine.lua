---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_pine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_pine.init()

    return {
        description = "Alternative pine tree decorations from ethereal-ng",
        depends = {
            "dirt_ordinary",
            -- (From schematic)
            "tree_pine",
        },
        optional = {
            "biome_ethereal_forest_coniferous",
            "biome_ethereal_taiga",
            "dirt_ordinary_with_turf_cold",
        },
    }

end

function unilib.pkg.deco_ethereal_tree_pine.exec()

    if unilib.pkg_executed_table["dirt_ordinary_with_turf_cold"] ~= nil and
            unilib.pkg_executed_table["biome_ethereal_forest_coniferous"] ~= nil then

        -- Large pine tree for lower elevations
        unilib.register_decoration("ethereal_tree_pine_lowland", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_pine_ethereal.mts",

            fill_ratio = 0.025,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_taiga"] ~= nil then

        -- Small pine tree for lower elevations (using same schematic)
        unilib.register_decoration("ethereal_tree_pine_highland", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_pine_ethereal.mts",

            fill_ratio = 0.025,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
         })

    end

end

function unilib.pkg.deco_ethereal_tree_pine.post()

    if unilib.pkg_executed_table["dirt_ordinary_with_turf_cold"] ~= nil and
            unilib.pkg_executed_table["biome_ethereal_forest_coniferous"] ~= nil then

        unilib.register_decoration_now("ethereal_tree_pine_lowland", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_coniferous",
            place_on = {
                "unilib:dirt_ordinary_with_litter_coniferous",
                "unilib:dirt_ordinary_with_turf_cold",
            },
            y_max = 40,
            y_min = 10,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_taiga"] ~= nil then

        unilib.register_decoration_now("ethereal_tree_pine_highland", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_taiga",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            y_max = 140,
            y_min = 40,
        })

    end

end

