---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_phlox_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_phlox_normal.init()

    return {
        description = "Normal phlox as decoration",
        depends = {"dirt_ordinary_with_turf", "tree_apple"},
        at_least_one = {"biome_default_forest_deciduous", "biome_ethereal_forest_deciduous"},
    }

end

function unilib.pkg.deco_elysflowers_flower_phlox_normal.post()

    unilib.register_decoration_complete("elysflowers_flower_phlox_normal", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_phlox_normal"
        biomes = {"default_forest_deciduous", "ethereal_forest_deciduous"},
        num_spawn_by = 1,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:tree_apple_trunk",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
