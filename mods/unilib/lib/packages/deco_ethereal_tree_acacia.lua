---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_acacia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_acacia.init()

    return {
        description = "Alternative acacia tree decoration from ethereal-ng",
        depends = {"biome_ethereal_savanna", "tree_acacia"},
        at_least_one = {"dirt_dry", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_tree_acacia.exec()

    unilib.register_decoration("ethereal_tree_acacia", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_acacia.mts",

        fill_ratio = 0.004,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_tree_acacia.post()

    unilib.register_decoration_now("ethereal_tree_acacia", nil, {
        -- From ethereal-ng/schems.lua
        biomes = "ethereal_savanna",
        place_on = {"unilib:dirt_dry_with_turf_dry", "unilib:dirt_ordinary_with_turf_dry"},
        y_max = 100,
        y_min = 1,
    })

end
