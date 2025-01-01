---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_pine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_pine.init()

    return {
        description = "Alternative pine tree decorations from ethereal-ng",
        depends = {"dirt_ordinary", "tree_pine"},
        at_least_one = {"biome_ethereal_forest_coniferous", "biome_ethereal_taiga"},
    }

end

function unilib.pkg.deco_ethereal_tree_pine.exec()

    if unilib.global.pkg_executed_table["biome_ethereal_forest_coniferous"] ~= nil then

        -- Large pine tree for lower elevations
        unilib.register_decoration_generic("ethereal_tree_pine_lowland", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_pine_large.mts",

            fill_ratio = 0.025,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
        })

        -- Small pine tree for higher elevations
        unilib.register_decoration_generic("ethereal_tree_pine_highland", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_pine_small.mts",

            fill_ratio = 0.025,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
         })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_taiga"] ~= nil then

        -- Snowy large pine tree for lower elevations
        unilib.register_decoration_generic("ethereal_tree_pine_snowy_lowland", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_tree_pine_large_snowy_from_sapling.mts",

            fill_ratio = 0.025,
            flags = "place_center_x, place_center_z",
            sidelen = 80,
        })

        -- Snowy small pine tree for higher elevations
        unilib.register_decoration_generic("ethereal_tree_pine_snowy_highland", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_tree_pine_small_snowy_from_sapling.mts",

            flags = "place_center_x, place_center_z",
            fill_ratio = 0.025,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_tree_pine.post()

    if unilib.global.pkg_executed_table["biome_ethereal_forest_coniferous"] ~= nil then

        unilib.register_decoration_complete("ethereal_tree_pine_lowland", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_coniferous",
            place_on = "unilib:dirt_ordinary_with_litter_coniferous",
            y_max = 50,
            y_min = 4,
        })

        unilib.register_decoration_complete("ethereal_tree_pine_highland", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_coniferous",
            place_on = "unilib:dirt_ordinary_with_litter_coniferous",
            y_max = 140,
            y_min = 50,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_taiga"] ~= nil then

        unilib.register_decoration_complete("ethereal_tree_pine_snowy_lowland", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_taiga",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            y_max = 50,
            y_min = 4,
        })

        unilib.register_decoration_complete("ethereal_tree_pine_snowy_highland", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_taiga",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            y_max = 140,
            y_min = 50,
        })

    end

end
