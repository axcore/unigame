---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_melon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_melon.init()

    return {
        description = "Melon as decoration",
        depends = {"dirt_ordinary", "produce_melon"},
    }

end

function unilib.pkg.deco_farming_redo_produce_melon.post()

    unilib.register_decoration_complete("farming_redo_produce_melon", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_melon"
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_dry",
        },
        spawn_by = {"group:water", "group:sand"},
        y_max = 3,
        y_min = 1,
    })

end
