---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_pine_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_pine_log.init()

    return {
        description = "Pine tree log as decoration",
        depends = {"dirt_ordinary", "tree_pine"},
        at_least_one = {"biome_ethereal_forest_coniferous", "biome_ethereal_taiga"},
    }

end

function unilib.pkg.deco_ethereal_tree_pine_log.exec()

    unilib.register_decoration_generic("ethereal_tree_pine_log", {
        -- From ethereal-ng/decor.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_pine_log.mts",

        fill_ratio = 0.0018,
        flags = "place_center_x",
        place_offset_y = 1,
        rotation = "random",
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_tree_pine_log.post()

    unilib.register_decoration_complete("ethereal_tree_pine_log", nil, {
        -- From ethereal-ng/schems.lua
        biomes = {"ethereal_forest_coniferous", "ethereal_taiga"},
        num_spawn_by = 8,
        place_on = {
            "unilib:dirt_ordinary_with_cover_snow",
            "unilib:dirt_ordinary_with_litter_coniferous",
        },
        spawn_by = {
            "unilib:dirt_ordinary_with_cover_snow",
            "unilib:dirt_ordinary_with_litter_coniferous",
        },
        y_max = 100,
        y_min = 4,
    })

end
