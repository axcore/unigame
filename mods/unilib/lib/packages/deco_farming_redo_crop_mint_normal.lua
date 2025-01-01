---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_crop_mint_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_crop_mint_normal.init()

    return {
        description = "Normal mint as decoration",
        depends = "crop_mint_normal",
        at_lease_one = {"dirt_ordinary", "dirt_ordinary_with_turf_bamboo"},
    }

end

function unilib.pkg.deco_farming_redo_crop_mint_normal.post()

    unilib.register_decoration_complete("farming_redo_crop_mint_normal", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "crop_mint_normal"
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_bamboo",
        },
        spawn_by = {"group:sand", "group:water"},
        y_max = 75,
        y_min = 1,
    })

end
