---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_corn_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_corn_normal.init()

    return {
        description = "Normal corn as decoration",
        depends = {"dirt_ordinary", "produce_corn_normal"},
    }

end

function unilib.pkg.deco_farming_redo_produce_corn_normal.post()

    unilib.register_decoration_complete("farming_redo_produce_corn_normal", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_corn_normal"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_prairie"},
        y_max = 27,
        y_min = 12,
    })

end
