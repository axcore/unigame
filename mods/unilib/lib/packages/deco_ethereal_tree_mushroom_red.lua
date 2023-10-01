---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_mushroom_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_mushroom_red.init()

    return {
        description = "Red mushroom tree as decoration",
        depends = {
            "biome_ethereal_mushroom",
            "dirt_ordinary_with_turf_mushroom",
            "tree_mushroom_red",
        },
    }

end

function unilib.pkg.deco_ethereal_tree_mushroom_red.post()

    unilib.register_decoration_now("ethereal_tree_mushroom_red", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_mushroom_red"
        biomes = "ethereal_mushroom",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_turf_mushroom",
        spawn_by = "unilib:dirt_ordinary_with_turf_mushroom",
        y_max = 100,
        y_min = 1,
    })

end
