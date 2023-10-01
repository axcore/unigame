---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_redwood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_redwood.init()

    return {
        description = "Redwood tree as decoration",
        depends = {"biome_ethereal_mesa", "dirt_ordinary", "tree_redwood"},
    }

end

function unilib.pkg.deco_ethereal_tree_redwood.post()

    unilib.register_decoration_now("ethereal_tree_redwood_normal", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_redwood"
        biomes = "ethereal_mesa",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_turf_dry",
        spawn_by = "unilib:dirt_ordinary_with_turf_dry",
        y_max = 100,
        y_min = 1,
    })

end
