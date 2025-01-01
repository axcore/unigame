---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_beetroot_merlin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_beetroot_merlin.init()

    return {
        description = "Merlin beetroot as decoration",
        depends = {"biome_default_grassland", "crop_beetroot_merlin", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_better_farming_crop_beetroot_merlin.post()

    unilib.register_decoration_complete("better_farming_crop_beetroot_merlin", nil, {
        -- From better_farming, beetroot.lua
        -- Completes decoration in package "crop_beetroot_merlin"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
