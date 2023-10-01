---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grave
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_grave_tree_oak_graveyard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grave.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_grave_tree_oak_graveyard.init()

    return {
        description = "Graveyard oak tree as decoration",
        depends = {"dirt_graveyard", "tree_oak_graveyard"},
    }

end

function unilib.pkg.deco_grave_tree_oak_graveyard.exec()

    unilib.register_decoration_now("grave_tree_oak_graveyard", nil, {
        -- From grave/mapgen.lua
        -- Completes decoration in package "tree_oak_graveyard"
        place_on = "unilib:dirt_graveyard_with_turf_graveyard",
        y_max = unilib.y_max,
        y_min = 1,
    })

end

