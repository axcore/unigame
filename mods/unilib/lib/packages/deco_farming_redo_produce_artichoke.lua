---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_artichoke = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_artichoke.init()

    return {
        description = "Artichoke as decoration",
        depends = {"dirt_ordinary", "produce_artichoke"},
    }

end

function unilib.pkg.deco_farming_redo_produce_artichoke.exec()

    unilib.register_decoration_now("farming_redo_produce_artichoke", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_artichoke"
        num_spawn_by = 1,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "group:tree",
        y_max = 13,
        y_min = 1,
    })

end
