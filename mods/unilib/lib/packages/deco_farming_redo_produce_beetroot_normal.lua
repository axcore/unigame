---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_beetroot_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_beetroot_normal.init()

    return {
        description = "Normal beetroot as decoration",
        depends = {"dirt_ordinary", "produce_beetroot_normal"},
    }

end

function unilib.pkg.deco_farming_redo_produce_beetroot_normal.exec()

    unilib.register_decoration_now("farming_redo_produce_beetroot_normal", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_beetroot_normal"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 15,
        y_min = 1,
    })

end
