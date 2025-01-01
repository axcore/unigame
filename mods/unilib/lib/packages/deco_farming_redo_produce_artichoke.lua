---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_artichoke = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_artichoke.init()

    return {
        description = "Artichoke as decoration",
        depends = "produce_artichoke",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_grove"},
    }

end

function unilib.pkg.deco_farming_redo_produce_artichoke.post()

    unilib.register_decoration_complete("farming_redo_produce_artichoke", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_artichoke"
        num_spawn_by = 1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_grove"},
        spawn_by = "group:tree",
        y_max = 13,
        y_min = 1,
    })

end
