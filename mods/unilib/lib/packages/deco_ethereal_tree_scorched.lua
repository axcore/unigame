---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_scorched = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_scorched.init()

    return {
        description = "Scorched tree as decoration",
        depends = {"biome_ethereal_plains", "dirt_dried", "tree_scorched"},
    }

end

function unilib.pkg.deco_ethereal_tree_scorched.post()

    unilib.register_decoration_complete("ethereal_tree_scorched", nil, {
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "tree_scorched"
        biomes = "ethereal_plains",
        place_on = "unilib:dirt_dried",
        y_max = 100,
        y_min = 1,
    })

end
