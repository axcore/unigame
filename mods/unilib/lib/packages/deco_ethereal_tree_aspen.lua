---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_aspen = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_aspen.init()

    return {
        description = "Alternative aspen tree decoration from ethereal-ng",
        depends = {"biome_ethereal_grassy", "dirt_ordinary", "tree_aspen"},
    }

end

function unilib.pkg.deco_ethereal_tree_aspen.exec()

    unilib.register_decoration("ethereal_tree_aspen", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_aspen.mts",

        fill_ratio = 0.02,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_tree_aspen.post()

    unilib.register_decoration_now("ethereal_tree_aspen", nil, {
        -- From ethereal-ng/schems.lua
        biomes = "ethereal_grassy",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 50,
        y_min = 1,
    })

end

