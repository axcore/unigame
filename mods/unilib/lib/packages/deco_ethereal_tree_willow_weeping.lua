---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_willow_weeping = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_willow_weeping.init()

    return {
        description = "Weeping Willow tree as decoration",
        depends = {
            "biome_ethereal_grayness",
            "dirt_ordinary_with_turf_grey",
            "tree_willow_weeping",
        },
    }

end

function unilib.pkg.deco_ethereal_tree_willow_weeping.post()

    unilib.register_decoration_now("ethereal_tree_willow_weeping", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_willow_weeping"
        biomes = "ethereal_grayness",
        num_spawn_by = 6,
        place_on = "unilib:dirt_ordinary_with_turf_grey",
        spawn_by = "unilib:dirt_ordinary_with_turf_grey",
        y_max = 100,
        y_min = 1,
    })

end
