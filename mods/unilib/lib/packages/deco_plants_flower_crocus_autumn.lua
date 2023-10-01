---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_flower_crocus_autumn = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_flower_crocus_autumn.init()

    return {
        description = "Autumn crocus as decoration",
        depends = {"dirt_ordinary", "flower_crocus_autumn", "stone_ordinary_with_iron"},
    }

end

function unilib.pkg.deco_plants_flower_crocus_autumn.post()

    unilib.register_decoration_now("plants_flower_crocus_autumn", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "flower_crocus_autumn"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:stone_ordinary_with_iron",
        y_max = 40,
        y_min = 2,
    })

end
