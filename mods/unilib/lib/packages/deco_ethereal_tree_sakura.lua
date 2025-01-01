---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_sakura = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_sakura.init()

    return {
        description = "Sakura tree as decoration",
        depends = {"biome_ethereal_bamboo", "dirt_ordinary_with_turf_bamboo", "tree_sakura"},
    }

end

function unilib.pkg.deco_ethereal_tree_sakura.post()

    unilib.register_decoration_complete("ethereal_tree_sakura", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_sakura"
        biomes = "ethereal_bamboo",
        num_spawn_by = 6,
        place_on = "unilib:dirt_ordinary_with_turf_bamboo",
        spawn_by = "unilib:dirt_ordinary_with_turf_bamboo",
        y_max = 35,
        y_min = 7,
    })

end
