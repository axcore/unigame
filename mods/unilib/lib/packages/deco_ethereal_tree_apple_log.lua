---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_apple_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_apple_log.init()

    return {
        description = "Apple tree log as decoration",
        depends = {"dirt_ordinary", "tree_apple"},
        at_least_one = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_jumble",
            "biome_ethereal_swamp",
            "biome_ethereal_prairie",
        },
    }

end

function unilib.pkg.deco_ethereal_tree_apple_log.exec()

    unilib.register_decoration_generic("ethereal_tree_apple_log", {
        -- From ethereal-ng/decor.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_apple_log.mts",

        fill_ratio = 0.001,
        flags = "place_center_x",
        place_offset_y = 1,
        rotation = "random",
        sidelen = 16,
    })

end

function unilib.pkg.deco_ethereal_tree_apple_log.post()

    unilib.register_decoration_complete("ethereal_tree_apple_log", nil, {
        -- From ethereal-ng/schems.lua
        biomes = {
            "ethereal_forest_deciduous",
            "ethereal_jumble",
            "ethereal_prairie",
            "ethereal_swamp",
        },
        num_spawn_by = 8,
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        spawn_by = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        y_max = 100,
        y_min = 1,
    })

end
