---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_lettuce = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_lettuce.init()

    return {
        description = "Lettuce as decoration",
        depends = {"dirt_ordinary", "produce_lettuce"},
    }

end

function unilib.pkg.deco_farming_redo_produce_lettuce.exec()

    unilib.register_decoration_now("farming_redo_produce_lettuce", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_lettuce"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 30,
        y_min = 5,
    })

end
