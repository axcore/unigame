---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_plant_cacao_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_plant_cacao_wild.init()

    return {
        description = "Wild cacao plant as decoration",
        depends = {"dirt_ordinary", "plant_cacao_wild", "sand_desert"},
    }

end

function unilib.pkg.deco_plants_plant_cacao_wild.post()

    unilib.register_decoration_now("plants_plant_cacao_wild", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "plant_cacao_wild"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:sand_desert",
        y_max = 90,
        y_min = 20,
    })

end
