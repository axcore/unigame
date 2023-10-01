---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_healing = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_healing.init()

    return {
        description = "healing tree as decoration",
        depends = {"biome_ethereal_taiga", "dirt_ordinary", "tree_healing"},
    }

end

function unilib.pkg.deco_ethereal_tree_healing.post()

    unilib.register_decoration_now("ethereal_tree_healing", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_healing"
        biomes = "ethereal_taiga",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_cover_snow",
        spawn_by = "unilib:dirt_ordinary_with_cover_snow",
        y_max = 140,
        y_min = 120,
    })

end
