---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_healing = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_healing.init()

    return {
        description = "healing tree as decoration",
        depends = {"dirt_ordinary", "tree_healing"},
        at_least_one = {"biome_ethereal_glacier", "biome_ethereal_mountain"},
    }

end

function unilib.pkg.deco_ethereal_tree_healing.post()

    unilib.register_decoration_complete("ethereal_tree_healing", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_healing"
        biomes = {"ethereal_glacier", "ethereal_mountain"},
        num_spawn_by = 8,
        place_on = {"unilib:dirt_ordinary_with_cover_snow", "unilib:snow_ordinary_block"},
        spawn_by = "unilib:dirt_ordinary_with_cover_snow",
        y_max = 160,
        y_min = 150,
    })

end
