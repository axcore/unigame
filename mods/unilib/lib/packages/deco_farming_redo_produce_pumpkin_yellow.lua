---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_pumpkin_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_pumpkin_yellow.init()

    return {
        description = "Yellow Pumpkin as decoration",
        depends = {"dirt_ordinary", "produce_pumpkin_yellow"},
    }

end

function unilib.pkg.deco_farming_redo_produce_pumpkin_yellow.post()

    unilib.register_decoration_complete("farming_redo_produce_pumpkin_yellow", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_pumpkin_yellow"
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_litter_rainforest",
        },
        spawn_by = {"group:water", "group:sand"},
        y_max = 3,
        y_min = 1,
    })

end
