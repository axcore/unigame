---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_flower_lavender_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_flower_lavender_wild.init()

    return {
        description = "Wild lavender as decoration",
        depends = {"dirt_ordinary", "flower_lavender_wild", "sand_ordinary"},
    }

end

function unilib.pkg.deco_plants_flower_lavender_wild.post()

    unilib.register_decoration_complete("plants_flower_lavender_wild", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "flower_lavender_wild"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:sand_ordinary",
        y_max = 60,
        y_min = 2,
    })

end
