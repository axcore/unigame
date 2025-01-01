---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_flower_poppy_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_flower_poppy_wild.init()

    return {
        description = "Wild poppy as decoration",
        depends = {"flower_poppy_wild", "liquid_water_ordinary", "sand_desert"},
    }

end

function unilib.pkg.deco_plants_flower_poppy_wild.post()

    unilib.register_decoration_complete("plants_flower_poppy_wild", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "flower_poppy_wild"
        place_on = "unilib:sand_desert",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 20,
        y_min = 2,
    })

end
