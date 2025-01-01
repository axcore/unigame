---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_vine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_vine.init()

    return {
        description = "Vine tree as decoration",
        depends = {"biome_ethereal_swamp", "dirt_ordinary", "tree_vine"},
    }

end

function unilib.pkg.deco_ethereal_tree_vine.post()

    unilib.register_decoration_complete("ethereal_tree_vine", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_swamp",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 100,
        y_min = 1,
    })

end
