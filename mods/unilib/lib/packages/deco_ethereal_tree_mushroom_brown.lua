---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_mushroom_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_mushroom_brown.init()

    return {
        description = "Brown mushroom tree as decoration",
        depends = {
            "biome_ethereal_mushroom",
            "dirt_ordinary_with_turf_mushroom",
            "tree_mushroom_brown",
        },
    }

end

function unilib.pkg.deco_ethereal_tree_mushroom_brown.post()

    unilib.register_decoration_complete("ethereal_tree_mushroom_brown", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_mushroom_brown"
        biomes = "ethereal_mushroom",
        num_spawn_by = 6,
        place_on = "unilib:dirt_ordinary_with_turf_mushroom",
        spawn_by = "unilib:dirt_ordinary_with_turf_mushroom",
        y_max = 50,
        y_min = 26,
    })

end
