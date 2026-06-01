---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_phlox_cold_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_phlox_cold_desert.init()

    return {
        description = "Cold desert phlox as decoration",
        at_least_one = {
            {"biome_default_desert_cold", "biome_ethereal_desert_cold"},
            {"dirt_ordinary_with_turf", "sand_ordinary", "sand_silver"},
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_phlox_cold_desert.post()

    unilib.register_decoration_complete("elysflowers_flower_phlox_cold_desert", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_phlox_cold_desert"
        biomes = {"default_desert_cold", "ethereal_desert_cold"},
        num_spawn_by = -1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:sand_ordinary", "unilib:sand_silver"},
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
