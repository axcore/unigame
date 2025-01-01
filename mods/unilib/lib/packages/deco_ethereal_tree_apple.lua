---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_apple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_apple.init()

    return {
        description = "Alternative apple tree decoration from ethereal-ng",
        depends = {"dirt_ordinary", "tree_apple"},
        at_least_one = {"biome_ethereal_forest_deciduous", "biome_ethereal_jumble"},
    }

end

function unilib.pkg.deco_ethereal_tree_apple.exec()

    unilib.register_decoration_generic("ethereal_tree_apple", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_apple.mts",

        fill_ratio = 0.025,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_tree_apple.post()

    unilib.register_decoration_complete("ethereal_tree_apple", nil, {
        -- From ethereal-ng/schems.lua
        biomes = {"ethereal_forest_deciduous", "ethereal_jumble"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 100,
        y_min = 1,
    })

end
