---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_rhubarb = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_rhubarb.init()

    return {
        description = "Rhubarb as decoration",
        depends = "produce_rhubarb",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_prairie"},
    }

end

function unilib.pkg.deco_farming_redo_produce_rhubarb.post()

    unilib.register_decoration_complete("farming_redo_produce_rhubarb", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_rhubarb"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_prairie"},
        y_max = 20,
        y_min = 3,
    })

end
