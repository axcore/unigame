---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_jungle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_jungle.init()

    return {
        description = "Alternative jungle tree decoration from ethereal-ng",
        depends = {"biome_ethereal_rainforest", "tree_jungle"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_rainforest"},
    }

end

function unilib.pkg.deco_ethereal_tree_jungle.exec()

    unilib.register_decoration("ethereal_tree_jungle", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_jungle.mts",

        fill_ratio = 0.08,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_tree_jungle.post()

    unilib.register_decoration_now("ethereal_tree_jungle", nil, {
        -- From ethereal-ng/schems.lua
        biomes = "ethereal_rainforest",
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf_rainforest",
        },
        y_max = 100,
        y_min = 1,
    })

end
