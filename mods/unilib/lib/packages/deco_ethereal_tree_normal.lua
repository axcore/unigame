---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_normal.init()

    return {
        description = "Normal tree as decoration",
        depends = {"biome_ethereal_jumble", "dirt_ordinary", "tree_normal"},
    }

end

function unilib.pkg.deco_ethereal_tree_normal.post()

    unilib.register_decoration_complete("ethereal_tree_normal", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_normal"
        biomes = "ethereal_jumble",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:dirt_ordinary_with_turf",
        y_max = 100,
        y_min = 1,
    })

end
