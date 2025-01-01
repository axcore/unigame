---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_pineapple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_pineapple.init()

    return {
        description = "Pineapple as decoration",
        depends = "produce_pineapple",
        at_least_one = {"dirt_ordinary", "dirt_dry"},
    }

end

function unilib.pkg.deco_farming_redo_produce_pineapple.post()

    unilib.register_decoration_complete("farming_redo_produce_pineapple", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_pineapple"
        place_on = {"unilib:dirt_dry_with_turf_dry", "unilib:dirt_ordinary_with_turf_dry"},
        y_max = 30,
        y_min = 11,
    })

end
