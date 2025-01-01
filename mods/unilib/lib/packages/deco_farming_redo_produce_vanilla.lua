---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_vanilla = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_vanilla.init()

    return {
        description = "Vanilla as decoration",
        depends = "produce_vanilla",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_grove"},
    }

end

function unilib.pkg.deco_farming_redo_produce_vanilla.post()

    unilib.register_decoration_complete("farming_redo_produce_vanilla", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_vanilla"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_grove"},
        y_max = 35,
        y_min = 5,
    })

end
