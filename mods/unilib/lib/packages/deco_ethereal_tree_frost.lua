---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_frost = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_frost.init()

    return {
        description = "Frost tree as decoration",
        depends = {"biome_ethereal_frost", "dirt_ordinary_with_turf_crystal", "tree_frost"},
    }

end

function unilib.pkg.deco_ethereal_tree_frost.post()

    unilib.register_decoration_complete("ethereal_tree_frost", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_frost"
        biomes = {"ethereal_frost", "ethereal_frost_floatland"},
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_turf_crystal",
        spawn_by = "unilib:dirt_ordinary_with_turf_crystal",
        y_max = 1750,
        y_min = 1,
    })

end
