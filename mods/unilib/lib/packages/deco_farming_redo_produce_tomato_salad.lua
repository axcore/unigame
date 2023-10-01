---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_tomato_salad = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_tomato_salad.init()

    return {
        description = "Salad tomato as decoration",
        depends = {"dirt_ordinary", "produce_tomato_salad"},
    }

end

function unilib.pkg.deco_farming_redo_produce_tomato_salad.exec()

    unilib.register_decoration_now("farming_redo_produce_tomato_salad", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_tomato_salad"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 20,
        y_min = 5,
    })

end
