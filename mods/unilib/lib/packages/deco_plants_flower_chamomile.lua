---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_flower_chamomile = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_flower_chamomile.init()

    return {
        description = "Chamomile flower as decoration",
        depends = {"dirt_ordinary", "flower_chamomile", "stone_ordinary_with_coal"},
    }

end

function unilib.pkg.deco_plants_flower_chamomile.post()

    unilib.register_decoration_complete("plants_flower_chamomile", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "flower_chamomile"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:stone_ordinary_with_coal",
        y_max = 40,
        y_min = 2,
    })

end
