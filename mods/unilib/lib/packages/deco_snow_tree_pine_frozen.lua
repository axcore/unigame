---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_snow_tree_pine_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_snow_tree_pine_frozen.init()

    return {
        description = "Frozen pine tree as decoration",
        depends = {"dirt_ordinary", "tree_pine_frozen"},
        at_least_one = {"biome_snow_forest", "biome_snow_lush", "biome_snow_normal"},
    }

end

function unilib.pkg.deco_snow_tree_pine_frozen.post()

    if unilib.global.pkg_executed_table["biome_snow_normal"] ~= nil then

        unilib.register_decoration_complete("snow_tree_pine_frozen_1", nil, {
            -- From snow/mapgen_v7.lua
            -- Completes decoration in package "tree_pine_frozen"
            biomes = "snow_normal",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            -- N.B. Not in original code; using same values as pine trees from default, to prevent
            --      pine trees floating on water
            y_max = unilib.constant.y_max,
            y_min = 4,
        })

    end

    if unilib.global.pkg_executed_table["biome_snow_forest"] ~= nil then

        unilib.register_decoration_complete("snow_tree_pine_frozen_2", nil, {
            -- From snow/mapgen_v7.lua
            -- Completes decoration in package "tree_pine_frozen"
            biomes = "snow_forest",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            -- N.B. Not in original code
            y_max = unilib.constant.y_max,
            y_min = 4,
        })

    end

    if unilib.global.pkg_executed_table["biome_snow_lush"] ~= nil then

        unilib.register_decoration_complete("snow_tree_pine_frozen_3", nil, {
            -- From snow/mapgen_v7.lua
            -- Completes decoration in package "tree_pine_frozen"
            biomes = "snow_lush",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            -- N.B. Not in original code
            y_max = unilib.constant.y_max,
            y_min = 4,
        })

    end

end
